#!/usr/bin/env python3

import inspect
import io, os, sys

from PIL import Image
import sqlite3

# Enable run as script: ./mbtdisplay.py
SCRIPT_DIR = os.path.realpath(os.path.dirname(inspect.getfile(inspect.currentframe())))
ROOT_DIR = os.path.normpath(os.path.join(SCRIPT_DIR, '..'))
sys.path.append(ROOT_DIR)

from mbtidime import mbtcoord



def main(mbtpath, mode, lat, lon, zoom_input):
    conn = sqlite3.connect(mbtpath)
    # conn.row_factory = sqlite3.Row
    assert mode in ('degrees', 'tile')

    if zoom_input == 'all':
        # Retrieve zoom levels:
        zooms = [row[0] for row in conn.execute("SELECT DISTINCT zoom_level FROM tiles").fetchall()]
    else:
        zooms = [float(zoom_input)]

    for zoom in zooms:
        if mode == 'tile':
            col, row = float(lat), float(lon)
        else:
            col, row = mbtcoord.deg2num(float(lat), float(lon), zoom)

        # fmt = conn.execute("SELECT value FROM metadata WHERE name='format'").fetchone()[0]
        q = f"""SELECT tile_data
            FROM tiles
            WHERE tile_column=? AND tile_row=? AND zoom_level=?"""
        imrows = conn.execute(q, (col, row, zoom)).fetchall()
        print(col, row, zoom, '->', len(imrows), 'image(s)')
        if len(imrows) > 0:
            imbytes = imrows[0][0]
            im = Image.open(io.BytesIO(imbytes))
            im.show()

    conn.close()


if __name__ == '__main__':
    main(*sys.argv[1:])

# eg mbtdisplay.py frit1.mbtiles 44.1152 7.42 9
