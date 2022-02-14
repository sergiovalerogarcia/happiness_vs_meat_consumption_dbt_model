{{
  config(
    alias='failures_' ~ dbt_testing.generate_name_with_execution_type(this.name)
    )
}}

with
-- given
{% set columns = [
    '"LOCATION"','"SUBJECT"','"MEASURE"',   '"TIME"','"Value"',
] %}
{% set list_values = [
    ['AUS',      'BEEF',         'KG_CAP',       2020,  20.2274657594685,],
    ['AUS',      'PIG',          'KG_CAP',       2020,  20.7237889821808,],
    ['AUS',      'POULTRY',      'KG_CAP',       2020,  45.7468517415389,],
    ['AUS',      'SHEEP',        'KG_CAP',       2020,  8.67055981573212,],
    ['AUS',      'BEEF',         'THND_TONNE',   2020,  739.677216586373,],
    ['AUS',      'PIG',          'THND_TONNE',   2020,  680.100925681739,],
    ['AUS',      'POULTRY',      'THND_TONNE',   2020,  1330.69138945576,],
    ['AUS',      'SHEEP',        'THND_TONNE',   2020,  252.210564209806,],
    ['NOR',      'PIG',          'THND_TONNE',   2020,  140.8,],
    ['NOR',      'POULTRY',      'THND_TONNE',   2020,  105.3,],
    ['NOR',      'BEEF',         'THND_TONNE',   2020,  106.7,],
    ['NOR',      'SHEEP',        'THND_TONNE',   2020,  28.25,],
] %}

-- when
create_meat_consumption_worldwide_dataset as (
    {{ create_meat_consumption_worldwide_dataset(
        columns=columns,
        list_values=list_values,
    ) }}
),

-- then
assert as (
    {{ dbt_testing.assert_equal(
        expected=ref('meat_consumption_worldwide_example'),
        actual='create_meat_consumption_worldwide_dataset',
        columns=columns,
    ) }}
)

select
    *
from assert
