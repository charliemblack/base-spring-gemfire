#!/bin/bash

export TEST_CASE_HOME=`dirname $0`/..

source $TEST_CASE_HOME/bin/env.sh

pushd  $TEST_CASE_HOME/bin/logs  > /dev/null  2>&1

options=-Xmx512m
options="$options -Xms512m"
options="$options -XX:+UseParNewGC"
options="$options -XX:+UseConcMarkSweepGC"
options="$options -XX:CMSInitiatingOccupancyFraction=50"
options="$options -XX:+UseStringCache"
options="$options -XX:+UseCompressedStrings"
options="$options -XX:+AggressiveOpts"
options="$options -XX:+UseCompressedOops"
#
java ${options}  demo.vmware.finra.ReadDataFile  file:$TEST_CASE_HOME/resources/spring-gemfire-client.xml

popd  > /dev/null  2>&1