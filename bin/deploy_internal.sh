#!/bin/bash

HOSTS="smdw smdw2 smdw3 "
SSH_USERNAME=gpadmin

for curr_host in ${HOSTS}
do
  ssh ${SSH_USERNAME}@${curr_host}  "mkdir -p /data/FINRA/poc"   > /dev/null  2>&1
  rsync -avz -e ssh  /data/FINRA/poc/ ${SSH_USERNAME}@${curr_host}:/data/FINRA/poc
  ssh ${SSH_USERNAME}@${curr_host}  "cd /data/FINRA/poc/bin; ./clear_gemfire.sh"
done

