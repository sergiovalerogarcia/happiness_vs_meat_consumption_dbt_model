#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

WORLD_HAPPINESS_DATASET=$1
YEAR_LIKE=$2
YEAR=$3
TABLE_EXISTS=$4
EXTRA_VARS=$5

./dbt_packages/happiness/scripts/run_happiness_facts.sh \
    "$WORLD_HAPPINESS_DATASET" \
    "$YEAR_LIKE" \
    "$YEAR" \
    "$TABLE_EXISTS" \
    "$EXTRA_VARS"
