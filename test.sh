#!/usr/bin/env bash

hyperfine --prepare 'rm processed/*.db || true' \
  'ogr2ogr -f SQLite -dsco SPATIALITE=YES -lco geometry_name=geometry -nln census_2020 processed/ogr2ogr.db processed/counties_2020.geojson' \
  'sqlite3x processed/json.db ".read tests/sqlite-json/load.sql"' \
  'pipenv run geojson-to-sqlite processed/gts.db census_2020 processed/counties_2020.geojson --spatialite' \
  'sqlite3x processed/vg.db ".read tests/virtual-geojson/load.sql"'