#!/bin/bash
set -eo pipefail
IFS=$'\n\t'

if [[ $RUN_IN_ALL_PACKAGES == "true" ]]
then
    ./dbt_packages/happiness/scripts/create_all_models.sh "~/workspace/data/dbt/dbt_testing/happiness/discovery/data/world_happiness_dataset"
else
echo "============
Seeds and copy...
============"
    ./scripts/copy_tables_using_seeds_schemas.sh
fi

echo "============
Run models...
============"

./scripts/subject_kg_to_souls_dim.sh ""

./scripts/meat_consumption_facts.sh ""

./scripts/happiness_vs_meat_consumption_facts.sh ""

echo "============
Run test...
============"
dbt test -s happiness --exclude tag:unit_tests tag:integration_tests
