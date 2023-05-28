with source as (
      select * from {{ source('jaffle_shop', 'customers') }}
),
final as (
    select *
    from source
)
select * from final
