with green as (
    select
        *,
        'green' as taxi
    from {{ ref('int_distance_per_day_part_green') }}
),

yellow as (
    select
        *,
        'yellow' as taxi
    from {{ ref('int_distance_per_day_part_yellow') }}
),

final as (
    select * from green
    union all
    select * from yellow
)

select * from final
