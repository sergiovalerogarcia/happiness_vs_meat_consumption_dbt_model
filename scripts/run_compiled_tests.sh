#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

RELATIVE_DIR="$1"

CONNECTION="postgresql://$DBT_USER:$DBT_PASSWORD@$DBT_HOST:$DBT_PORT/$DBT_DBNAME"
PREFIX_DIR="target/compiled/happiness_vs_meat_consumption/"

SCRIPT=$(cat ${PREFIX_DIR}/${RELATIVE_DIR})

TEST_DIR="logs/tests/"
mkdir -p ${TEST_DIR}

OUTPUT_FILE="${TEST_DIR}last_result.log"

psql ${CONNECTION} -c "${SCRIPT}" > ${TEST_DIR}last_result.log

code ${TEST_DIR}last_result.log