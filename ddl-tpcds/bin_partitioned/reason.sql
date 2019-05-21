create database if not exists ${DB};
use ${DB};

drop table if exists reason;

create external table reason
stored as ${FILE}
location '${LOCATION}/partitioned/reason'
as select * from ${SOURCE}.reason;
