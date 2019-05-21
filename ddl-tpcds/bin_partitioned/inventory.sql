create database if not exists ${DB};
use ${DB};

drop table if exists inventory;

create external table inventory
stored as ${FILE}
location '${LOCATION}/partitioned/inventory'
tblproperties('DO_NOT_UPDATE_STATS'='TRUE')
as select * from ${SOURCE}.inventory
CLUSTER BY inv_date_sk
;
