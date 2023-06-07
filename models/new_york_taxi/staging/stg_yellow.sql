select *
from {{ source('new_york_taxi', 'yellow') }}