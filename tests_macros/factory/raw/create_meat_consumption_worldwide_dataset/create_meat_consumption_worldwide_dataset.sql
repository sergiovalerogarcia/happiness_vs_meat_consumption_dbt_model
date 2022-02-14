{% macro create_meat_consumption_worldwide_dataset(columns, list_values) %}
    {{ dbt_testing.create_dataset(
        default_columns_and_types=[
            { 'column': '"LOCATION"','type': 'varchar' },
            { 'column': '"SUBJECT"', 'type': 'varchar' },
            { 'column': '"MEASURE"', 'type': 'varchar' },
            { 'column': '"TIME"',    'type': 'int' },
            { 'column': '"Value"',   'type': 'float' },
        ],
        list_values=list_values,
        columns=columns,
    )}}
{% endmacro %}
