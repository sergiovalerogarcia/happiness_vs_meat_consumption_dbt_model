#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

./dbt_packages/happiness/scripts/create_all_models.sh
