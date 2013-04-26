#!/bin/bash


HOSTS="mdw smdw smdw2 smdw3 "
SSH_USERNAME=gpadmin


for curr_host in ${HOSTS}
do
  ssh ${SSH_USERNAME}@${curr_host}  "pkill -9 java"   > /dev/null  2>&1  &
done

wait