{% macro happiness_vs_meat_consumption_facts(
    countries_dim_table_ref,
    happiness_facts_table_ref,
    meat_consumption_facts_table_ref
) %}

with
happiness_vs_meat_consumption_facts as (
    select
        cd.country_name,
        hf.year,
        hf.score,
        hf.gdp_per_capita,
        hf.social_support,
        hf.healthy_life_expectancy,
        hf.freedom_to_make_life_choices,
        hf.generosity,
        hf.perceptions_of_corruption,
        hf.dystopia_plus_residual,
        mcf.consumed_souls_per_capita,
        mcf.million_consumed_souls
    from
        {{ countries_dim_table_ref }} as cd
        join {{ happiness_facts_table_ref }} as hf on (
            hf.country_name_sk = cd.country_name_sk
        )
        join {{ meat_consumption_facts_table_ref }} as mcf on (
            mcf.country_code_3_sk = cd.country_code_3_sk and
            mcf.year = hf.year
        )
),

num_of_years as (
    select count(distinct year)
    from happiness_vs_meat_consumption_facts
),

-- when
countries_not_in_all_years as (
    select
        country_name,
        count(*) as occurrences
    from happiness_vs_meat_consumption_facts
    group by
        country_name
    having count(*) != ( select * from num_of_years)
),

filter_countries_not_in_all_years as (
    select
        *
    from happiness_vs_meat_consumption_facts
    where country_name not in ( select country_name from countries_not_in_all_years )
)

select *
from filter_countries_not_in_all_years

{% endmacro %}