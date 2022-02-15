{% macro standardize_meat_consumption_with_sk(table_ref) %}
    with
    standardize_meat_consumption as (
        {{ happiness_vs_meat_consumption.standardize_meat_consumption(table_ref) }}
    )

    select
        *,
        {{ dbt_utils.surrogate_key(['country_code_3']) }} as country_code_3_sk
    from standardize_meat_consumption
{% endmacro %}