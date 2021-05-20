#!/usr/bin/env python3

import inspect
from itertools import islice
import io
from math import ceil
# from multiprocessing import Pool
import os
import subprocess
import sys

import sqlite3


# Enable run as script: ./mbtdisplay.py
SCRIPT_DIR = os.path.realpath(os.path.dirname(inspect.getfile(inspect.currentframe())))  #type:ignore
ROOT_DIR = os.path.normpath(os.path.join(SCRIPT_DIR, '..'))
sys.path.append(ROOT_DIR)


"""
! needs pngnq 1.1 for overwrite.  see https://sourceforge.net/p/pngnq/bugs/6/
to address this pngnq-s9 has been installed thus:

```
git clone https://github.com/ImageProcessing-ElectronicPublications/pngnq-s9
cd pngnq-s9
./configure CFLAGS="-O3 -msse -funroll-loops"
sed -i 's/automake-1.15/automake-1.16/g' Makefile
aclocal
sudo make install
```
"""

def split_in_n(lst, n):
    """ also https://more-itertools.readthedocs.io/en/latest/api.html#more_itertools.divide """
    it = iter(lst)
    return (list(islice(it, n)) for i in range(int(len(lst)/n)))


def sum_size(paths):
    return sum(os.stat(path).st_size for path in paths)


def mbt_compress(conn, dst_conn, tilefolder):
    # dest = mbtpath.replace('.mbtiles', '-compressed.mbtiles')
    # assert not os.path.exists(dest), 'Not overwriting ' + dest
    # tmp dir:
    os.makedirs(tilefolder, exist_ok=True)

    ntiles = conn.execute("SELECT COUNT(*) FROM tiles;").fetchone()[0]
    print('Processing', ntiles, 'tiles')

    c_select = conn.cursor()
    c_select.execute(f"""SELECT zoom_level, tile_column, tile_row, tile_data FROM tiles""")
    nprocessed = 0

    N_TILES_BATCH = 100
    N_SHELL_PROCESSES = 8
    while True:  # batch
        paths = {}
        size_before = 0

        for zoom_level, tile_column, tile_row, tile_data in islice(c_select, N_TILES_BATCH):
            tile_path = f"{tilefolder}/{zoom_level}-{tile_column}-{tile_row}.png"
            with io.open(tile_path, 'wb') as f:
                f.write(tile_data)
            paths[tile_path] = (zoom_level, tile_column, tile_row, os.stat(tile_path).st_size)
            size_before += os.stat(tile_path).st_size
        # sizes = [os.stat(tile_path).st_size]

        if not paths:
            break 

        shell_batch_size = ceil(len(paths) / N_SHELL_PROCESSES)

        compress_cmds = [
            'pngnq-s9 -f -e .png'.split(),
            'optipng -q -o1 -zc9 -zm8 -zs3 -f4'.split()
        ]
        sizes = [sum_size(paths)]
        for cmd in compress_cmds:
            # path_list = list(paths.keys())
            # cmd.extend(path_list)
            # subprocess.check_call(cmd)
            threads = []
            path_it = iter(paths)
            for _ in range(N_SHELL_PROCESSES):
                path_batch = list(islice(path_it, shell_batch_size))
                if path_batch:  # not at the very end
                    threads.append(subprocess.Popen(cmd + path_batch))

            for x in threads:
                retcode = x.wait()
                if retcode:
                    raise subprocess.CalledProcessError(retcode, cmd)

            # print('Size after step ', i, ':', sum(os.stat(tile_path).st_size for tile_path in paths))
            sizes.append(sum_size(paths))

        def row_iter():
            for tile_path in paths:
                zoom_level, tile_column, tile_row, old_size = paths[tile_path]
                if not os.stat(tile_path).st_size >= old_size:
                    with open(tile_path, 'rb') as f:
                        yield (f.read(), zoom_level, tile_column, tile_row)

        if conn != dst_conn:
            query = "INSERT INTO tiles (tile_data, zoom_level, tile_column, tile_row) VALUES (?,?,?,?)"
        else:
            query = "UPDATE tiles SET tile_data=? WHERE zoom_level=? AND tile_column=? AND tile_row=?"
        n_updated = dst_conn.executemany(query, row_iter()).rowcount
        dst_conn.commit()

        nprocessed += len(paths)
        print('Sizes', '->'.join(map(str,sizes)),
              '; Updated: ', n_updated,
              '; Progress:', int(100*nprocessed/ntiles), '%')

        for tile_path in paths:
            os.remove(tile_path)  # (keep files until inserted correctly)

    conn.close()


def main(mbtpath, create_path=''):
    conn = sqlite3.connect(mbtpath)
    try:
        fmt = conn.execute("SELECT value FROM metadata WHERE name='format'").fetchone()[0].lower()
        assert fmt == 'png', 'Expected PNG format, got ' + fmt

        if create_path:
            is_new = not os.path.isfile(create_path)
            dst_conn = sqlite3.connect(create_path)
            if is_new:
                dst_conn.executescript(f'''
                    ATTACH "{mbtpath}" AS old;
                    CREATE TABLE tiles (zoom_level integer, tile_column integer, tile_row integer, tile_data blob);
                    CREATE UNIQUE INDEX tiles_idx ON tiles (zoom_level, tile_column, tile_row);
                    CREATE TABLE metadata (name text, value text);
                    INSERT INTO metadata SELECT * FROM old.metadata;
                ''')
        else:
            dst_conn = conn
        tilefolder = 'tiles-' + mbtpath.replace('.mbtiles', '')
        mbt_compress(conn, dst_conn, tilefolder)
        if not create_path:  # compress existing
            conn.execute('VACUUM;')
    finally:
        conn.close()


if __name__ == '__main__':
    if len(sys.argv) < 2 or sys.argv[1] in ('-h', '--help'):
        print(sys.argv[0], '<mbtiles_to_read> [mbtiles_to_write]')
        exit(-1)
    main(*sys.argv[1:])
