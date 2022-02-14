{% macro meat_consumption_facts(table_ref) %}
    select *
    from {{ table_ref }}
{% endmacro %}