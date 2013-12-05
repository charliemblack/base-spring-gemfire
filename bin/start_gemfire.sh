#!/bin/bash

source `dirname $0`/env.sh


${TEST_CASE_HOME}/bin/start_locator.sh

${TEST_CASE_HOME}/bin/start_data_node.sh 1

${TEST_CASE_HOME}/bin/start_data_node.sh 2

${TEST_CASE_HOME}/bin/start_data_node.sh 3

wait
