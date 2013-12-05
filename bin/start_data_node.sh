#!/bin/bash

if [ $# -lt 1 ]
then
        echo "Usage : $0 server_number"
        exit
fi

source `dirname $0`/env.sh

mkdir $TEST_CASE_HOME/data/server$1 > /dev/null  2>&1

rm -f $TEST_CASE_HOME/data/server$1/.cacheserver.ser  > /dev/null  2>&1

options=-Dgemfire.name=server$1
options="$options -Xmx1g"
options="$options -Xms1g"
#options="$options -XX:+UseParNewGC"
#options="$options -XX:+UseConcMarkSweepGC"
#options="$options -XX:CMSInitiatingOccupancyFraction=50"
options="$options -XX:+AggressiveOpts"
#options="$options -XX:MaxNewSize=2g -XX:NewSize=2g"
#options="$options -XX:+UseCompressedOops"

#options="$options -Dgemfire.tombstone-timeout=1000"
#options="$options -Dgemfire.tombstone-gc-threshold=200"
#options="$options -Dgemfire.non-replicated-tombstone-timeout=1000"
#options="$options -Dgemfire.tombstone-scan-interval=5000"

#options="$options -Djava.util.logging.config.file=$TEST_CASE_HOME/resources/logging.properties"

pushd  $TEST_CASE_HOME/data/server$1 > /dev/null 2>&1
java $options demo.gemfire.Server > start_up.log 2>&1  &
popd > /dev/null 2>&1
