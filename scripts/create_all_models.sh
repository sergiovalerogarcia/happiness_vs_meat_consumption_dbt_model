#!/bin/bash
set -eo pipefail
IFS=$'\n\t'

if [[ $RUN_IN_ALL_PACKAGES == "true" ]]
then
    ./dbt_packages/happiness/scripts/create_all_models.sh "~/workspace/data/dbt/dbt_testing/happiness/discovery/data/world_happiness_dataset"
fi
