{% macro mock_subject_kg_to_souls() %}
    {% set columns = [
        'subject', 'kg',
    ] %}
    {% set list_values = [
        ['BEEF',200.0,],
        ['PIG',100.0,],
        ['POULTRY',2.5,],
        ['SHEEP',80.0,],
    ] %}

    {{ create_subject_kg_to_souls_dataset(
        columns=columns,
        list_values=list_values,
    ) }}
{% endmacro %}