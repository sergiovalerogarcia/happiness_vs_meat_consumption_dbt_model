{{
  config(
    materialized='table',
    alias=dbt_testing.generate_name_with_execution_type(this.name)
    )
}}

with
{% set countries_dim_table_ref = ref('happiness', 'countries_dim') %}
{% set happiness_facts_table_ref = ref('happiness', 'happiness_facts') %}

{% if dbt_testing.integration_tests_run_mode() %}
    {% set countries_dim_table_ref = 'mock_countries_dim' %}
    {{ countries_dim_table_ref }} as (
      {{ mock_countries_dim() }}
    ),
    {% set happiness_facts_table_ref = 'mock_happiness_facts' %}
    {{ happiness_facts_table_ref }} as (
      {{ mock_happiness_facts() }}
    ),
{% endif %}

happiness_vs_meat_consumption_facts as (
    {{ happiness_vs_meat_consumption_facts(
        countries_dim_table_ref=countries_dim_table_ref,
        happiness_facts_table_ref=happiness_facts_table_ref,
        meat_consumption_facts_table_ref=ref('meat_consumption_facts'),
    ) }}
)

select *
from happiness_vs_meat_consumption_facts