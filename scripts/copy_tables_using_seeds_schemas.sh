#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

DATA_PATH="$1"
./dbt_packages/happiness/scripts/copy_tables_using_seeds_schemas.sh "$DATA_PATH"
