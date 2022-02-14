#!/bin/bash
set -eo pipefail
IFS=$'\n\t'

if [[ $RUN_IN_ALL_PACKAGES == "true" ]]
then
    ./dbt_packages/happiness/scripts/copy_tables_using_seeds_schemas.sh "~/workspace/data/dbt/dbt_testing/happiness/discovery/data/world_happiness_dataset"
fi

DATA_PATH="/home/sergio/workspace/data/dbt/dbt_testing/happiness_vs_meat_consumption/discovery/data/worldwide_meat_consumption_dataset/meat_consumption_worldwide.csv"
CONNECTION=postgresql://$USER:$PASSWORD@$HOST:$PORT/$DBNAME

copy_table_using_seed_schema() {
    TABLE=$1
    EXAMPLE=$2
    FILE=$3

    echo $TABLE
    psql $CONNECTION -c "create schema if not exists happiness"
    psql $CONNECTION -c "create table if not exists $TABLE as select * from $EXAMPLE"
    psql $CONNECTION -c "truncate table $TABLE"
    psql $CONNECTION -c "\copy $TABLE from '$FILE' csv header"
}

dbt seed -s happiness_vs_meat_consumption

copy_table_using_seed_schema \
    "happiness.meat_consumption_worldwide" \
    "happiness_tests.meat_consumption_worldwide_example" \
    "$DATA_PATH"