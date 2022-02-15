{% macro create_standardize_meat_consumption_with_sk_dataset(columns, list_values) %}
    {{ dbt_testing.create_dataset(
        default_columns_and_types=[
            { 'column': 'country_code_3',   'type': 'varchar' },
            { 'column': 'country_code_3_sk','type': 'varchar' },
            { 'column': 'subject',          'type': 'varchar' },
            { 'column': 'year',             'type': 'int' },
            { 'column': 'thnd_tonne',       'type': 'float' },
            { 'column': 'kg_cap',           'type': 'float' },
        ],
        list_values=list_values,
        columns=columns,
    )}}
{% endmacro %}
