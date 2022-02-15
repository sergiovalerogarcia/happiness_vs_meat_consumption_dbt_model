{% macro mock_happiness_facts() %}
    {% set columns = [
    'year','country_name_sk',               'score',    'gdp_per_capita','social_support','healthy_life_expectancy','freedom_to_make_life_choices','generosity','perceptions_of_corruption','dystopia_plus_residual',
    ] %}
    {% set list_values = [
        [2020,'4442e4af0916f53a07fb8ca9a49b98ed',7.222799778,1.310396433,   1.477146268,        1.022607684,            0.621877193,                    0.335996419,    0.324973613,            2.129804134,]
    ] %}

    {{ happiness.create_happiness_facts_dataset(
        columns=columns,
        list_values=list_values,
    ) }}

{% endmacro %}