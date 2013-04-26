#!/bin/bash

TEST_CASE_HOME=`dirname $0`/..

source $TEST_CASE_HOME/bin/env.sh

gfsh -e "connect --locator=localhost[55221]" -e "shutdown --time-out=15"

gfsh stop locator --dir=$TEST_CASE_HOME/data/locator
