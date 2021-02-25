
# Helper to show what we have inside an mbtile: min/max zoom, number of tiles, bounds.

mbt_info() {
  echo "SELECT MIN(zoom_level), MAX(zoom_level), COUNT(*) FROM tiles ; SELECT value FROM metadata WHERE name = 'bounds';" | sqlite3 "$1" | tr '\n' ' '
  echo
}

# Merge without dealing with conlicts, which means if there is overlapping data:
# * either append will fail because of a unique index
# * or you will end up with duplicate tiles
# Does not update the bounds.

mbt_append()  # append_mbt $source $dest
{
  echo "ATTACH \"$1\" AS low; INSERT INTO main.tiles SELECT * FROM low.tiles;" | sqlite3 "$2"
}

# Does a "real" merge, relying on [Upsert](https://www.sqlite.org/lang_UPSERT.html), which was added to SQLite with version 3.24.0 (2018-06-04).
# It relies on an index for the conflict detection, but at least `gdal` and *Atlas Creator* have none, so:
#   * we deduplicate, keep *last*
#   * we create the index as needed (as d
# It does not update the bounds.

mbt_merge()  # `merge_mbt $source $dest`. source overwrites dest
{
  echo -n "|  $1 " ; mbt_info "$1"
  echo -n "-> $2 " ; mbt_info "$2"
  sqlite3 "$2" <<EOF
    DELETE FROM tiles WHERE rowid NOT IN (SELECT MAX(rowid) FROM tiles GROUP BY zoom_level, tile_column, tile_row);
    CREATE UNIQUE INDEX IF NOT EXISTS xyz ON tiles (zoom_level, tile_column, tile_row);
    ATTACH "$1" AS low;
    INSERT INTO main.tiles SELECT * FROM low.tiles WHERE true ON CONFLICT (zoom_level, tile_column, tile_row) DO UPDATE SET tile_data=excluded.tile_data;
EOF
  mbt_info "$2"
}


# Extract given tile number: x/y given as TMS coordinates, and z zoom level

tile_zxy() { # tile $mbtiles $z $x $y [$dest_folder]
  foldr="${5:-"${1/.mbtiles/}-tiles"}"
  mkdir -p $foldr
  ext=$(sqlite3 "$1" "SELECT value FROM metadata WHERE name='format'")
  q="SELECT writefile('$foldr/$2-$3-$4.$ext', tile_data) FROM tiles WHERE zoom_level=$2 AND tile_column=$3 AND tile_row=$4 LIMIT 1"
  sqlite3 "$1" "$q"
  ls -l $foldr/$2-$3-$4.$ext
}

first_tile() { # first_tile $mbtiles
  tpath=${1/.mbtiles/}-firsttile.$ext
  echo -n "$tpath "
  ext=$(sqlite3 "$1" "SELECT value FROM metadata WHERE name='format'")
  sqlite3 "$1" "SELECT writefile('$tpath', tile_data) FROM tiles LIMIT 1"
}

mbt_create() # `mbt_create $dest`
{
  sqlite3 "$1" <<EOF
    CREATE TABLE tiles (zoom_level integer, tile_column integer, tile_row integer, tile_data blob);
    CREATE UNIQUE INDEX tiles_idx ON tiles (zoom_level, tile_column, tile_row);
    CREATE TABLE metadata (name text, value text);
EOF
}

# Note 758 is the length of an all-white tile. PNG size go up to 30K
mbt_split()  # `mbt_split $source $n_tiles`
{
  # set -o xtrace
  dest="${1/.mbtiles/}-split$2.mbtiles"
  mbt_create "$dest"
  sqlite3 "$1" <<EOF
    ATTACH "$dest" AS dest;
    INSERT INTO dest.metadata SELECT * FROM metadata;
    INSERT INTO dest.tiles SELECT * FROM main.tiles WHERE LENGTH(tile_data) > 758 LIMIT $2 ;
    DELETE FROM metadata WHERE name='bounds';
EOF
  mbt_info "$dest"
  # set +o xtrace
}
