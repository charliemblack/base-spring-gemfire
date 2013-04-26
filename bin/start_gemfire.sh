#!/bin/bash


HOSTS="smdw smdw2 smdw3"
SSH_USERNAME=gpadmin

machineNumber=1

ssh ${SSH_USERNAME}@mdw  "cd /data/FINRA/poc/bin; ./start_locator.sh"

for curr_host in ${HOSTS}
do
  echo Starting $machineNumber
  ssh ${SSH_USERNAME}@${curr_host}  "cd /data/FINRA/poc/bin; ./start_data_node.sh ${machineNumber}"
  machineNumber=$[machineNumber+1]
done

# There was some wierd thing up with java and being able to spawn two large JVMs concurrently.
# Lets leave that for another day
sleep 10

for curr_host in ${HOSTS}
do
  echo Starting $machineNumber
  ssh ${SSH_USERNAME}@${curr_host}  "cd /data/FINRA/poc/bin; ./start_data_node.sh ${machineNumber}"
  machineNumber=$[machineNumber+1]
done

