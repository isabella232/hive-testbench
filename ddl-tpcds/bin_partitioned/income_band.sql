create database if not exists ${DB};
use ${DB};

drop table if exists income_band;

create external table income_band
stored as ${FILE}
location '${LOCATION}/partitioned/income_band'
as select * from ${SOURCE}.income_band;
