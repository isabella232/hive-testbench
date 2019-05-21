create database if not exists ${DB};
use ${DB};

drop table if exists item;

create external table item
stored as ${FILE}
location '${LOCATION}/partitioned/item'
as select * from ${SOURCE}.item
CLUSTER BY i_item_sk
;
