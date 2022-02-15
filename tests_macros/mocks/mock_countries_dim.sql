{% macro mock_countries_dim() %}
    {% set columns = [
        'country_name','country_code_3','country_name_sk',                  'country_code_3_sk',
    ] %}
    {% set list_values = [
        ['Norway',      'NOR',          'd5b9290a0b67727d4ba1ca6059dc31a6','11d451c440c4cc34a0238a0482f1c6da',],
        ['Australia',   'AUS',          '4442e4af0916f53a07fb8ca9a49b98ed','8faa77c9cf7465efb7d16af6a0b2630c',],
    ] %}

    {{ happiness.create_countries_dim_dataset(
        columns=columns,
        list_values=list_values,
    ) }}
{% endmacro %}