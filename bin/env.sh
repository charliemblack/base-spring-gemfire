#!/bin/bash

pushd  `pwd` > /dev/null
cd `dirname $0`/..
export TEST_CASE_HOME=`pwd`
popd > /dev/null

export JAVA_HOME=/data/FINRA/jdk1.7.0_17
export GEMFIRE=/data/FINRA/vFabric_GemFire_701_b40235

export PATH=$JAVA_HOME/bin:$GEMFIRE/bin:$PATH

for file in ${TEST_CASE_HOME}/target/*.jar
do
  export CLASSPATH=$file:$CLASSPATH
done

for file in ${TEST_CASE_HOME}/target/lib/*.jar
do
  export CLASSPATH=$file:$CLASSPATH
done

