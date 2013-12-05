#!/bin/bash

pushd  `pwd` > /dev/null
cd `dirname $0`/..
export TEST_CASE_HOME=`pwd`
popd > /dev/null

for file in ${TEST_CASE_HOME}/target/*.jar
do
  export CLASSPATH=$file:$CLASSPATH
done

for file in ${TEST_CASE_HOME}/target/lib/*.jar
do
  export CLASSPATH=$file:$CLASSPATH
done

