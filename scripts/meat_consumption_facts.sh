#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

EXTRA_VARS=$1

echo "============
Run run...
============"
dbt run -s happiness_vs_meat_consumption.meat_consumption_facts.meat_consumption_facts \
    --vars "{$EXTRA_VARS}"

echo "============
Run test...
============"
dbt test -s happiness_vs_meat_consumption.meat_consumption_facts.meat_consumption_facts --exclude tag:integration_tests \
    --vars "{$EXTRA_VARS}"