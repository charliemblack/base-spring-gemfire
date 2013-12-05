#!/bin/bash

TEST_CASE_HOME=`dirname $0`/..

source $TEST_CASE_HOME/bin/env.sh

pushd  $TEST_CASE_HOME/bin/logs > /dev/null 2>&1

gfsh -e "connect --locator=localhost[10334]" -e "list members" -e "shutdown --time-out=15" -e "list members"

gfsh stop locator --dir=$TEST_CASE_HOME/data/locator

popd > /dev/null 2>&1
