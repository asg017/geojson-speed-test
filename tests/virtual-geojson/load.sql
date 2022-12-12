.load /usr/local/lib/mod_spatialite.dylib

-- create a virtual table
create virtual table geojson using VirtualGeoJSON('processed/counties_2020.geojson');

-- read it into a table
create table counties_2020 as
select
    *
from
    geojson;

-- done with the virtual table
drop table geojson;