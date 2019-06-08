#!/bin/bash

function usage {
    echo "Usage: tpcds-setup-change-location.sh scale_factor [old_directory] [new_directory]"
    exit 1
}

function runcommand {
    if [ "X$DEBUG_SCRIPT" != "X" ]; then
	$1
    else
	$1 2>/dev/null
    fi
}

which hive > /dev/null 2>&1
if [ $? -ne 0 ]; then
	echo "Script must be run where Hive is installed"
	exit 1
fi

which hadoop > /dev/null 2>&1
if [ $? -ne 0 ]; then
	echo "Script must be run where Hadoop is installed"
	exit 1
fi

# Get the parameters.
SCALE=$1
OLDDIR=$2
NEWDIR=$3

# Sanity checking.
if [ X"$SCALE" = "X" ]; then
    usage
fi

if [ X"$OLDDIR" = "X" ]; then
    OLDDIR=/tmp/tpcds-generate
fi

if [ X"$NEWDIR" = "X" ]; then
    NEWDIR=s3a://testbucket/tpcds-generate
fi

if [ ${SCALE} -eq 1 ]; then
    echo "Scale factor must be greater than 1"
    exit 1
fi

echo "Copying data from ${OLDDIR} to ${NEWDIR}"
hadoop distcp -delete "${OLDDIR}" "${NEWDIR}"

HIVE="beeline -n hive -u 'jdbc:hive2://localhost:2181/;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2?tez.queue.name=default' "

echo "Changing location of text/flat tables"
runcommand "$HIVE -i settings/load-flat.sql -f ddl-tpcds/changelocation.sql --hivevar DB=tpcds_text_${SCALE} --hivevar LOCATION=${NEWDIR}/${SCALE}"

echo "Changing location of orc tables"
runcommand "$HIVE -f ddl-tpcds/changelocation.sql --hivevar DB=tpcds_bin_partitioned_${FORMAT}_${SCALE} --hivevar LOCATION=${NEWDIR}/${SCALE}/partitioned"

echo "Location changed successfully."
