#!/bin/bash

pushd  `pwd` > /dev/null
cd `dirname $0`/..
export TEST_CASE_HOME=`pwd`
popd > /dev/null

HOSTS="10.110.123.236"
SSH_USERNAME=gpadmin

$TEST_CASE_HOME/bin/clear_gemfire.sh

filename=$(basename $TEST_CASE_HOME)

pushd $TEST_CASE_HOME > /dev/null  2>&1

mvn package dependency:copy-dependencies

popd   > /dev/null  2>&1

ssh ${SSH_USERNAME}@${HOSTS}  "mkdir /data/FINRA/poc"   > /dev/null  2>&1
rsync -avz -e ssh  $TEST_CASE_HOME/ ${SSH_USERNAME}@${HOSTS}:/data/FINRA/poc

echo Cloning to other hosts
ssh ${SSH_USERNAME}@${HOSTS}  "/data/FINRA/poc/bin/deploy_internal.sh"   > /dev/null  2>&1
echo Done

