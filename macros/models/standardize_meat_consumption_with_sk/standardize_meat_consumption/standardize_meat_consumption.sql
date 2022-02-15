{% macro standardize_meat_consumption(table_ref) %}
    with
    rename_columns as (
        select
            "LOCATION" as country_code_3,
            "SUBJECT" as subject,
            "MEASURE" as measure,
            "TIME" as year,
            "Value" as value
        from {{ table_ref }}
    ),

    filter_thnd_tonne as (
        select
            *
        from rename_columns
        where measure = 'THND_TONNE'
    ),

    filter_kg_cap as (
        select
            *
        from rename_columns
        where measure = 'KG_CAP'
    ),

    pivot_measures as (
        select
            coalesce(ftt.country_code_3, fkp.country_code_3) as country_code_3,
            coalesce(ftt.subject, fkp.subject) as subject,
            coalesce(ftt.year, fkp.year) as year,
            ftt.value as thnd_tonne,
            fkp.value as kg_cap
        from filter_thnd_tonne as ftt
            full join filter_kg_cap as fkp
            on (
                ftt.country_code_3 = fkp.country_code_3 and
                ftt.subject = fkp.subject and
                ftt.year = fkp.year
            )
    )

    select *
    from pivot_measures
{% endmacro %}
