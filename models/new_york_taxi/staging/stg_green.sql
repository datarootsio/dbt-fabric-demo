with src as (
    select *
    from {{ source('new_york_taxi', 'green') }}
),

final as (
    select *
    from src
)

select *
from final