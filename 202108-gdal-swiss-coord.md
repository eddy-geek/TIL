Les itinéraires de www.sac-cas.ch sont transférés au navigateur en geojson, dans un système de coordonnées local, le MN95 aka CH1903+ / LV95 aka [EPSG:2056](https://epsg.io/2056),
détaillé dans [swisstopo:Le système de coordonnées suisse](https://www.swisstopo.admin.ch/fr/connaissances-faits/mensuration-geodesie/coordonnees/coordonnees-suisses.html).

Example de requête (la bbox est en MN95 aussi):
`https://www.suissealpine.sac-cas.ch/api/1/route/layer?bbox=2780000,1140000,2795000,1155000`

La norme geojson, elle, utilise les coordonnées GPS en degrés, aka WGS 84 aka EPSG:4326.
Example de conversion: https://epsg.io/transform#s_srs=2056&t_srs=4326&x=2783180.8800000&y=1154653.4800000

Conversion du geojson récupéré ci-dessus avec [gdal](https://gdal.org/programs/ogr2ogr.html):

```
ogr2ogr -s_srs EPSG:2056 -t_srs EPSG:4326 output.geojson input.geojson
```

on peut valider le fichier geojson sur https://geojson.io, et convertir le tout en gpx:

`ogr2ogr -s_srs EPSG:2056 -t_srs EPSG:4326 -nlt MULTILINESTRING output.gpx input.geojson`
