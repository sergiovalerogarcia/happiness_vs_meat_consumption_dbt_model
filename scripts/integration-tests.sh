#!/bin/bash
set -eo pipefail
IFS=$'\n\t'

echo "$(date +%s)" > logs/unique_identifier_it
UNIQUE_IDENTIFIER_IT=$(cat logs/unique_identifier_it)

if [[ $RUN_IN_ALL_PACKAGES == "true" ]]
then
    ./dbt_packages/happiness/scripts/integration-tests.sh
    UNIQUE_IDENTIFIER_IT=$(cat logs/unique_identifier_it)
fi

echo unique_identifier_it is $UNIQUE_IDENTIFIER_IT

echo "============
Run seeds...
============"

dbt seed -s happiness_vs_meat_consumption.raw_examples --vars "{'integration_tests':'true','unique_identifier':'$UNIQUE_IDENTIFIER_IT'}"

echo "============
Run models...
============"

./scripts/meat_consumption_facts.sh "'integration_tests':'true','unique_identifier':'$(cat logs/unique_identifier_it)'"

./scripts/subject_kg_to_souls_dim.sh "'integration_tests':'true','unique_identifier':'$(cat logs/unique_identifier_it)'"

echo "============
Run test...
============"

dbt test -s happiness_vs_meat_consumption --exclude tag:unit_tests --vars "{'integration_tests':'true','unique_identifier':'$UNIQUE_IDENTIFIER_IT'}"
