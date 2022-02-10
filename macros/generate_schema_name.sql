{% macro generate_schema_name(custom_schema_name, node) %}

    {{ dbt_testing.generate_schema_name(custom_schema_name, node) }}

{% endmacro %}
