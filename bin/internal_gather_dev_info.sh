#!/bin/bash

HOSTS="smdw smdw2 smdw3"
SSH_USERNAME=gpadmin

machineNumber=1

mkdir -p /data/FINRA/dev_info
pushd  /data/FINRA/dev_info

for curr_host in ${HOSTS}
do
  scp  ${SSH_USERNAME}@${curr_host}:/data/FINRA/poc/data/server${machineNumber}/gemfire-statistics.gfs ${curr-host}-server${machineNumber}.gfs
  machineNumber=$[machineNumber+1]
done

for curr_host in ${HOSTS}
do
  scp  ${SSH_USERNAME}@${curr_host}:/data/FINRA/poc/data/server${machineNumber}/gemfire-statistics.gfs ${curr-host}-server${machineNumber}.gfs
   machineNumber=$[machineNumber+1]
done

machineNumber=1

for curr_host in ${HOSTS}
do
  scp  ${SSH_USERNAME}@${curr_host}:/data/FINRA/poc/data/server${machineNumber}/server.log ${curr-host}-server${machineNumber}.log
  machineNumber=$[machineNumber+1]
done

for curr_host in ${HOSTS}
do
  scp  ${SSH_USERNAME}@${curr_host}:/data/FINRA/poc/data/server${machineNumber}/server.log ${curr-host}-server${machineNumber}.log
   machineNumber=$[machineNumber+1]
done


cd   /data/FINRA
zip -r dev_info.zip dev_info

popd
