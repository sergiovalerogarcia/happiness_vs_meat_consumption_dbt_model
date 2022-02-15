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

meat_consumption_worldwide_dataset as (
    {{ create_meat_consumption_worldwide_dataset(
        columns=columns,
        list_values=list_values,
    ) }}
),

-- when
standardize_meat_consumption_with_sk as (
    {{ standardize_meat_consumption_with_sk(
        table_ref='meat_consumption_worldwide_dataset',
    ) }}
),

-- then
{% set columns = [
    'country_code_3','country_code_3_sk',               'subject','year','thnd_tonne',          'kg_cap',
] %}
{% set list_values = [
    ['AUS',         '8faa77c9cf7465efb7d16af6a0b2630c', 'BEEF',     2020,   739.677216586373,   20.2274657594685,],
    ['AUS',         '8faa77c9cf7465efb7d16af6a0b2630c', 'PIG',      2020,   680.100925681739,   20.7237889821808,],
    ['AUS',         '8faa77c9cf7465efb7d16af6a0b2630c', 'POULTRY',  2020,   1330.69138945576,   45.7468517415389,],
    ['AUS',         '8faa77c9cf7465efb7d16af6a0b2630c', 'SHEEP',    2020,   252.210564209806,   8.67055981573212,],
    ['NOR',         '11d451c440c4cc34a0238a0482f1c6da', 'PIG',      2020,   140.8,              None,],
    ['NOR',         '11d451c440c4cc34a0238a0482f1c6da', 'POULTRY',  2020,   105.3,              None,],
    ['NOR',         '11d451c440c4cc34a0238a0482f1c6da', 'BEEF',     2020,   106.7,              None,],
    ['NOR',         '11d451c440c4cc34a0238a0482f1c6da', 'SHEEP',    2020,   28.25,              None,],
] %}

expected as (
    {{ create_standardize_meat_consumption_with_sk_dataset(
        columns=columns,
        list_values=list_values,
    ) }}
),

assert as (
    {{ dbt_testing.assert_equal(
        expected='expected',
        actual='standardize_meat_consumption_with_sk',
        columns=columns
    ) }}
)

select
    *
from assert
