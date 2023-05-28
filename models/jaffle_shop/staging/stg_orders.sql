with source as (
      select * from {{ source('jaffle_shop', 'orders') }}
),
final as (
    select *
    from source
)
select * from final
