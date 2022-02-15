{% macro meat_consumption_facts(meat_consumption_table_ref, subject_kg_to_souls_table_ref) %}
    with
    meat_consumption_facts_filter_incomplete_data as (
        {{ happiness_vs_meat_consumption.meat_consumption_facts_filter_incomplete_data(meat_consumption_table_ref) }}
    ),

    kg_to_souls as (
        select
            mc.country_code_3_sk,
            mc.year,
            round(
                (mc.kg_cap / kgtos.kg)::numeric,
                3
            ) as consumed_souls_per_capita,
            round(
                (mc.thnd_tonne / kgtos.kg)::numeric,
                3
            ) as million_consumed_souls
        from meat_consumption_facts_filter_incomplete_data as mc
            join {{ subject_kg_to_souls_table_ref }} as kgtos
            on (
                mc.subject = kgtos.subject
            )
    )

    select
        country_code_3_sk,
        year,
        round(
            sum(consumed_souls_per_capita),
            0
        )::float as consumed_souls_per_capita,
        round(
            sum(million_consumed_souls),
            0
        )::float as million_consumed_souls
    from kg_to_souls
    group by country_code_3_sk, year
{% endmacro %}
