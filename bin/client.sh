#!/bin/bash

export TEST_CASE_HOME=`dirname $0`/..

source $TEST_CASE_HOME/bin/env.sh

pushd  $TEST_CASE_HOME/bin/logs  > /dev/null  2>&1

options=-Xmx512m
options="$options -Xms512m"
options="$options -XX:+AggressiveOpts"

java ${options}  demo.gemfire.Client

popd  > /dev/null  2>&1