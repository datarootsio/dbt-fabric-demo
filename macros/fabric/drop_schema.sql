{% macro drop_schema(schema_to_drop=None) %}
  {% set schema_to_drop = schema_to_drop if schema_to_drop else target.schema %}

    {% set views_query %}
    SELECT v.name FROM sys.views v
    INNER JOIN sys.schemas s
    ON s.schema_id = v.schema_id
    AND s.name = '{{ schema_to_drop }}'
    {% endset %}
    {% set views_query_results = run_query(views_query) %}
    {% set view_names = views_query_results.columns[0].values() %}

    {% set tables_query %}
    SELECT t.name FROM sys.tables t
    INNER JOIN sys.schemas s
    ON s.schema_id = t.schema_id
    AND s.name = '{{ schema_to_drop }}'
    {% endset %}
    {% set tables_query_results = run_query(tables_query) %}
    {% set table_names = tables_query_results.columns[0].values() %}

    {% set drop_schema_query %}
    EXEC('DROP SCHEMA {{ schema_to_drop }}')
    {% endset %}

    {% for view_name in view_names %}
    {% set drop_view_query %}
        DROP VIEW {{ schema_to_drop }}.{{ view_name }}
    {% endset %}
    {{ log("Dropping view " ~ schema_to_drop ~ "." ~ view_name, info=True) }}
    {% do run_query(drop_view_query) %}
    {% endfor %}

    {% for table_name in table_names %}
    {% set drop_table_query %}
        DROP TABLE {{ schema_to_drop }}.{{ table_name }}
    {% endset %}
    {{ log("Dropping table " ~ schema_to_drop ~ "." ~ table_name, info=True) }}
    {% do run_query(drop_table_query) %}
    {% endfor %}

  {{ log("Dropping schema " ~ schema_to_drop, True) }}
  {% do run_query(drop_schema_query) %}

{% endmacro %}
