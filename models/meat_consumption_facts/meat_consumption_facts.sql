{{
  config(
    materialized='table',
    alias=dbt_testing.generate_name_with_execution_type(this.name)
    )
}}

with
{% set table_ref = ref('subject_kg_to_souls_dim') %}

{% if dbt_testing.integration_tests_run_mode() %}
    {% set table_ref = 'mock_subject_kg_to_souls_dim' %}
    {{ table_ref }} as (
      {{ mock_subject_kg_to_souls() }}
    ),
{% endif %}

meat_consumption_facts as (
  {{ meat_consumption_facts(
      meat_consumption_table_ref=ref('standardize_meat_consumption_with_sk'),
      subject_kg_to_souls_table_ref=table_ref,
  ) }}
)

select *
from meat_consumption_facts
