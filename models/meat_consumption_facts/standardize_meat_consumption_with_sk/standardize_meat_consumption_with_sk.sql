with
{% set table_ref = 'happiness.meat_consumption_worldwide' %}

{% if dbt_testing.integration_tests_run_mode() %}
    {% set table_ref = 'mock_meat_consumption_worldwide' %}
    {{ table_ref }} as (
      {{ mock_meat_consumption_worldwide() }}
    ),
{% endif %}

standardize_meat_consumption_with_sk as (
    {{ standardize_meat_consumption_with_sk(
        table_ref=table_ref,
    )}}
)

select *
from standardize_meat_consumption_with_sk