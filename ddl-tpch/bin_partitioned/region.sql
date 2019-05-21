create database if not exists ${DB};
use ${DB};

drop table if exists region;

create external table region
stored as ${FILE}
location '${LOCATION}/partitioned/region'
TBLPROPERTIES('orc.bloom.filter.columns'='*','orc.compress'='ZLIB')
as select distinct * from ${SOURCE}.region;
