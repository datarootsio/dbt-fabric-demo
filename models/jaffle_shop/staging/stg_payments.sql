with source as (
      select * from {{ source('jaffle_shop', 'payments') }}
),
final as (
    select *
    from source
)
select * from final
