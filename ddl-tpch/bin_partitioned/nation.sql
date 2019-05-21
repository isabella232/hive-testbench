create database if not exists ${DB};
use ${DB};

drop table if exists nation;

create external table nation
stored as ${FILE}
location '${LOCATION}/partitioned/nation'
TBLPROPERTIES('orc.bloom.filter.columns'='*','orc.compress'='ZLIB')
as select distinct * from ${SOURCE}.nation;
