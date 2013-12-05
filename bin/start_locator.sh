#!/bin/bash

TEST_CASE_HOME=`dirname $0`/..

source $TEST_CASE_HOME/bin/env.sh

mkdir -p $TEST_CASE_HOME/data/locator > /dev/null 2>&1
mkdir -p $TEST_CASE_HOME/bin/logs > /dev/null 2>&1

pushd  $TEST_CASE_HOME/bin/logs  > /dev/null 2>&1

gfsh start locator --name=locator1 --initial-heap=128m --max-heap=128m --dir=$TEST_CASE_HOME/data/locator --port=10334

popd  > /dev/null 2>&1
