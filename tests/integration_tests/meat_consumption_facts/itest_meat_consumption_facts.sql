{{
  config(
    alias='failures_' ~ dbt_testing.generate_name_with_execution_type(this.name),
    )
}}

with
-- given
meat_consumption_facts as (
    select *
    from {{ ref('meat_consumption_facts') }}
),

-- then
{% set columns = [
    'country_code_3_sk',                'year', 'consumed_souls_per_capita','million_consumed_souls',
] %}
{% set list_values = [
    ['8faa77c9cf7465efb7d16af6a0b2630c',  2020,    19,                      546,]
] %}

expected as (
    {{ create_meat_consumption_facts_dataset(
        columns=columns,
        list_values=list_values,
    ) }}
),

assert as (
    {{ dbt_testing.assert_equal(
        expected='expected',
        actual='meat_consumption_facts',
        columns=columns
    ) }}
)

select
    *
from assert
