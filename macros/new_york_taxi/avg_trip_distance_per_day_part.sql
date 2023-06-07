{% macro avg_trip_distance_per_day_part(model_name, pickup_dt_col_name, distance_col_name) %}
    with src_data as (
        select * from {{ ref(model_name) }}
    ),

    with_hours as (
        select *,
            datepart(hour, {{ pickup_dt_col_name }}) as pickup_hour
        from src_data
    ),

    with_day_part as (
        select *,
            case
                when pickup_hour between 6 and 11 then 'morning'
                when pickup_hour between 12 and 17 then 'afternoon'
                when pickup_hour between 18 and 23 then 'evening'
                when pickup_hour between 0 and 5 then 'night'
            end as pickup_day_part
        from with_hours
    ),

    final as (
        select
            pickup_day_part,
            avg({{ distance_col_name }}) as avg_distance
        from with_day_part
        group by pickup_day_part
    )

    select * from final
{% endmacro %}