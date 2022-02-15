{{
  config(
    alias='failures_' ~ dbt_testing.generate_name_with_execution_type(this.name)
    )
}}

-- given
with
num_of_years as (
    select count(distinct year)
    from {{ ref('happiness_vs_meat_consumption_facts') }}
),

-- when
countries_not_in_all_years as (
    select
        country_name,
        count(*) as occurrences
    from {{ ref('happiness_vs_meat_consumption_facts') }}
    group by
        country_name
    having count(*) != ( select * from num_of_years)
)

-- then
select
    *
from countries_not_in_all_years