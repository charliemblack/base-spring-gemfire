#!/bin/bash

export TEST_CASE_HOME=`dirname $0`/..

source $TEST_CASE_HOME/bin/env.sh

pushd  $TEST_CASE_HOME/bin/logs  > /dev/null  2>&1

java  -DgemfirePropertyFile=$TEST_CASE_HOME/resources/gemfire.properties -Dgemfire.cache-xml-file=$TEST_CASE_HOME/resources/client.xml demo.vmware.gemfire.poc.Validator

popd  > /dev/null  2>&1