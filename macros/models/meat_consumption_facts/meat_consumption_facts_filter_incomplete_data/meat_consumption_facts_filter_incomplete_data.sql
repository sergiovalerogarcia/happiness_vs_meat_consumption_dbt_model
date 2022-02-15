{% macro meat_consumption_facts_filter_incomplete_data(table_ref) %}
    select *
    from {{ table_ref }}
    where
        thnd_tonne is not null and
        kg_cap is not null
{% endmacro %}