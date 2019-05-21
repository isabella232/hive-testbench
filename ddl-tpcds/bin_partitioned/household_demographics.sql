create database if not exists ${DB};
use ${DB};

drop table if exists household_demographics;

create external table household_demographics
stored as ${FILE}
location '${LOCATION}/partitioned/household_demographics'
as select * from ${SOURCE}.household_demographics;
