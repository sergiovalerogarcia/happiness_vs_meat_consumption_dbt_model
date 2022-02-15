{% macro create_subject_kg_to_souls_dataset(columns, list_values) %}
    {{ dbt_testing.create_dataset(
        default_columns_and_types=[
            { 'column': 'subject',  'type': 'varchar' },
            { 'column': 'kg',       'type': 'float' },
        ],
        list_values=list_values,
        columns=columns,
    )}}
{% endmacro %}
