#!/bin/bash

TEST_CASE_HOME=`dirname $0`/..

source $TEST_CASE_HOME/bin/env.sh

mkidr -p $TEST_CASE_HOME/data/locator > /dev/null 2>&1
mkidr -p $TEST_CASE_HOME/bin/logs > /dev/null 2>&1

pushd  $TEST_CASE_HOME/bin/logs  > /dev/null 2>&1

gfsh start locator --name=locator1 --initial-heap=128m --max-heap=128m --dir=$TEST_CASE_HOME/data/locator --properties-file=$TEST_CASE_HOME/resources/cache.properties --port=55221

popd  > /dev/null 2>&1
