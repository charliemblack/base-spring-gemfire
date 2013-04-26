#!/bin/bash

HOSTS="10.110.123.236"
SSH_USERNAME=gpadmin

pushd  `pwd` > /dev/null
cd `dirname $0`/..
export TEST_CASE_HOME=`pwd`
popd > /dev/null

ssh ${SSH_USERNAME}@${HOSTS}  "cd /data/FINRA/poc/bin; ./internal_gather_dev_info.sh"
scp ${SSH_USERNAME}@${HOSTS}:/data/FINRA/dev_info.zip    ${TEST_CASE_HOME}/../
pushd   ${TEST_CASE_HOME}/../
unzip -o  dev_info.zip
popd
