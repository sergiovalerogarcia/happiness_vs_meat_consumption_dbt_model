{{
  config(
    alias='failures_' ~ dbt_testing.generate_name_with_execution_type(this.name)
    )
}}

with
-- given
{% set columns = [
    'subject', 'kg',
] %}
{% set list_values = [
    ['BEEF',200.0,],
    ['PIG',100.0,],
    ['POULTRY',2.5,],
    ['SHEEP',80.0,],
] %}

-- when
create_subject_kg_to_souls_dataset as (
    {{ create_subject_kg_to_souls_dataset(
        columns=columns,
        list_values=list_values,
    ) }}
),

-- then
assert as (
    {{ dbt_testing.assert_equal(
        expected=ref('subject_kg_to_souls_example'),
        actual='create_subject_kg_to_souls_dataset',
        columns=columns,
    ) }}
)

select
    *
from assert
