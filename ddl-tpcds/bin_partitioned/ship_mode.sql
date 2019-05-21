create database if not exists ${DB};
use ${DB};

drop table if exists ship_mode;

create external table ship_mode
stored as ${FILE}
location '${LOCATION}/partitioned/ship_mode'
as select * from ${SOURCE}.ship_mode;
