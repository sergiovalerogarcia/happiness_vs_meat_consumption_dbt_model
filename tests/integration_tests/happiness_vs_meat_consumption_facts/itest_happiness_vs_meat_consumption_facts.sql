{{
  config(
    alias='failures_' ~ dbt_testing.generate_name_with_execution_type(this.name),
    )
}}

with
-- given
meat_consumption_facts as (
    select *
    from {{ ref('happiness_vs_meat_consumption_facts') }}
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
        actual='meat_consumption_facts',
        columns=columns
    ) }}
)

select
    *
from assert
