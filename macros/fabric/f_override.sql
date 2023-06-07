{% macro fabric__rename_relation(from_relation, to_relation) -%}
  {% if to_relation.type == 'view' %}
    {% call statement('get_view_definition', fetch_result=True) %}
        SELECT m.[definition] AS VIEW_DEFINITION
        FROM sys.objects o
        INNER JOIN sys.sql_modules m
            ON m.[object_id] = o.[object_id]
        INNER JOIN sys.views v
            ON o.[object_id] = v.[object_id]
        INNER JOIN sys.schemas s
            ON o.schema_id = s.schema_id
            AND s.schema_id = v.schema_id
        WHERE s.name = '{{ from_relation.schema }}'
            AND v.name = '{{ from_relation.identifier }}'
            AND o.[type] = 'V';
    {% endcall %}

    {% set view_def_full = load_result('get_view_definition')['data'][0][0] %}
    {# Jinja does not allow bitwise operators and we need re.I | re.M here. So calculated manually this becomes 10. #}
    {% set final_view_sql = modules.re.sub("create\s+view\s+.*?\s+as\s+","",view_def_full, 10) %}

    {% call statement('create_new_view') %}
        {{ create_view_as(to_relation, final_view_sql) }}
    {% endcall %}
    {% call statement('drop_old_view') %}
        EXEC('DROP VIEW IF EXISTS {{ from_relation.include(database=False) }};');
    {% endcall %}
  {% endif %}
  {% if to_relation.type == 'table' %}
      {% call statement('rename_relation') %}
        EXEC('create table {{ to_relation.include(database=False) }} as select * from {{ from_relation.include(database=False) }}');
      {%- endcall %}
      {{ fabric__drop_relation(from_relation) }}
  {% endif %}
{% endmacro %}