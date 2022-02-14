{% macro create_meat_consumption_facts_dataset(columns, list_values) %}
    {{ dbt_testing.create_dataset(
        default_columns_and_types=[
            { 'column': 'country_code_3_sk',        'type': 'varchar' },
            { 'column': 'year',                     'type': 'int' },
            { 'column': 'consumed_souls_per_capita','type': 'float' },
            { 'column': 'million_consumed_souls',   'type': 'float' },
        ],
        list_values=list_values,
        columns=columns,
    )}}
{% endmacro %}
