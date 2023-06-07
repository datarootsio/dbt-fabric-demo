{% macro cents_to_dollars(column_name) %}
    convert(float, {{ column_name }}) / 100
{%- endmacro -%}