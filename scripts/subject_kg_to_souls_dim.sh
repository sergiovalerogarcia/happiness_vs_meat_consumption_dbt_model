#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

EXTRA_VARS=$1

echo "============
Run run...
============"
dbt run -s happiness_vs_meat_consumption.subject_kg_to_souls_dim.subject_kg_to_souls_dim \
    --vars "{$EXTRA_VARS}"

echo "============
Run test...
============"
dbt test -s happiness_vs_meat_consumption.subject_kg_to_souls_dim.subject_kg_to_souls_dim --exclude tag:integration_tests \
    --vars "{$EXTRA_VARS}"