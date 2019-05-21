create database if not exists ${DB};
use ${DB};

drop table if exists part;

create external table part
stored as ${FILE}
location '${LOCATION}/partitioned/part'
TBLPROPERTIES('orc.bloom.filter.columns'='*','orc.compress'='ZLIB')
as select * from ${SOURCE}.part
cluster by p_brand
;
