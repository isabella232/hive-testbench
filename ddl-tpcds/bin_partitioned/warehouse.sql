create database if not exists ${DB};
use ${DB};

drop table if exists warehouse;

create external table warehouse
stored as ${FILE}
location '${LOCATION}/partitioned/warehouse'
as select * from ${SOURCE}.warehouse;
