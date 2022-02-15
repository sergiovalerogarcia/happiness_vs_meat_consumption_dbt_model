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

{% set columns = [
    'subject', 'kg',
] %}
{% set list_values = [
    ['BEEF',200.0,],
    ['PIG',100.0,],
    ['POULTRY',2.5,],
    ['SHEEP',80.0,],
] %}

subject_kg_to_souls_dataset as (
    {{ create_subject_kg_to_souls_dataset(
        columns=columns,
        list_values=list_values,
    ) }}
),

{% set columns = [
    'country_name','country_code_3','country_name_sk',                  'country_code_3_sk',
] %}
{% set list_values = [
    ['Norway',      'NOR',          'd5b9290a0b67727d4ba1ca6059dc31a6','11d451c440c4cc34a0238a0482f1c6da',],
    ['Australia',   'AUS',          '4442e4af0916f53a07fb8ca9a49b98ed','8faa77c9cf7465efb7d16af6a0b2630c',],
] %}

countries_dim as (
    {{ happiness.create_countries_dim_dataset(
        columns=columns,
        list_values=list_values,
    ) }}
),

{% set columns = [
    'year','country_name_sk',               'score',    'gdp_per_capita','social_support','healthy_life_expectancy','freedom_to_make_life_choices','generosity','perceptions_of_corruption','dystopia_plus_residual',
] %}
{% set list_values = [
    [2020,'4442e4af0916f53a07fb8ca9a49b98ed',7.222799778,1.310396433,   1.477146268,        1.022607684,            0.621877193,                    0.335996419,    0.324973613,            2.129804134,]
] %}

happiness_facts as (
    {{ happiness.create_happiness_facts_dataset(
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

meat_consumption_facts as (
    {{ meat_consumption_facts(
        meat_consumption_table_ref='standardize_meat_consumption_with_sk',
        subject_kg_to_souls_table_ref='subject_kg_to_souls_dataset',
    ) }}
),

happiness_vs_meat_consumption_facts as (
    {{ happiness_vs_meat_consumption_facts(
        countries_dim_table_ref='countries_dim',
        happiness_facts_table_ref='happiness_facts',
        meat_consumption_facts_table_ref='meat_consumption_facts',
    ) }}
),

-- then
{% set columns = [
    'year','country_name',   'score',    'gdp_per_capita','social_support','healthy_life_expectancy','freedom_to_make_life_choices','generosity','perceptions_of_corruption','dystopia_plus_residual','consumed_souls_per_capita','million_consumed_souls',
] %}
{% set list_values = [
    [2020,'Australia',          7.222799778,1.310396433,   1.477146268,        1.022607684,            0.621877193,                    0.335996419,    0.324973613,            2.129804134,                 19,                     546,]
] %}


expected as (
    {{ create_happiness_vs_meat_consumption_facts_dataset(
        columns=columns,
        list_values=list_values,
    ) }}
),

assert as (
    {{ dbt_testing.assert_equal(
        expected='expected',
        actual='happiness_vs_meat_consumption_facts',
        columns=columns
    ) }}
)

select
    *
from assert
