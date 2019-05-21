create database if not exists ${DB};
use ${DB};

drop table if exists supplier;

create external table supplier
stored as ${FILE}
location '${LOCATION}/partitioned/supplier'
TBLPROPERTIES('orc.bloom.filter.columns'='*','orc.compress'='ZLIB')
as select * from ${SOURCE}.supplier
cluster by s_nationkey, s_suppkey
;
