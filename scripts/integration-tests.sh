#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

./dbt_packages/happiness/scripts/integration-tests.sh
