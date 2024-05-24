# OSM & Geocoder locally served capabilities demo

This docker composition includes a: 
- Postgis database with 2 schemas, one for OSM data used in context of Geoserver and one for Nominatim server
- Nominatim server, which on startup ingest data from a PBF mounted on a volume
- IMPOSM worker, which executes only one time and ingest data into OSM data schema for Geoserver based on the same PBF file mentioned before
- Geoserver instance, which serves WMS tiles generated using the OSM data in Postgis, using the catalog configuration, allowing to change styles dinamically, etc (also exposing OSM data via WFS)
- Nominatim-UI which uses all the local capabilities provided by the local Nominatim and the Geoserver basemaps.

![local served map with nominatim-ui demo using wms maps](img/osm-nominatim-screenshot.png)

