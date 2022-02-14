#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

EXTRA_VARS=$1

./dbt_packages/happiness/scripts/run_countries_dim.sh "$EXTRA_VARS"
