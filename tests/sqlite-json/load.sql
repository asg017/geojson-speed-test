.load /usr/local/lib/mod_spatialite.dylib

create table counties_2020 as
select 
  value ->> '$.properties.state_fips'     as state_fips,
  value ->> '$.properties.county_fips'    as county_fips,
  value ->> '$.properties.geoid'          as geoid,
  value ->> '$.properties.county_name'    as county_name,
  GeomFromGeoJSON(value ->> '$.geometry') as geometry
from json_each(readfile('processed/counties_2020.geojson'), '$.features');