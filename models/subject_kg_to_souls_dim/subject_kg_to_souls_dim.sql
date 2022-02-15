{{
  config(
    materialized='table',
    alias=dbt_testing.generate_name_with_execution_type(this.name)
    )
}}

with
{% set table_ref = ref('subject_kg_to_souls') %}

{% if dbt_testing.integration_tests_run_mode() %}
    {% set table_ref = 'mock_subject_kg_to_souls' %}
    {{ table_ref }} as (
      {{ mock_subject_kg_to_souls() }}
    ),
{% endif %}

subject_kg_to_souls_dim as (
    select *
    from {{ table_ref }}
)

select *
from subject_kg_to_souls_dim
