select *
from {{ source('new_york_taxi', 'green') }}