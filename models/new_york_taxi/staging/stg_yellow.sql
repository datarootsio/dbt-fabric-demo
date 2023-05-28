with src as (
    select *
    from {{ source('new_york_taxi', 'yellow') }}
),

final as (
    select *
    from src
)

select *
from final