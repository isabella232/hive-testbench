create database if not exists ${DB};
use ${DB};

drop table if exists partsupp;

create external table partsupp
stored as ${FILE}
location '${LOCATION}/partitioned/partsupp'
TBLPROPERTIES('orc.bloom.filter.columns'='*','orc.compress'='ZLIB')
as select * from ${SOURCE}.partsupp
cluster by PS_SUPPKEY
;

