-- GET DATA FROM SOURCES and make raw data look the way you want (perform some basic tranformaitons if needed)
with orders as (
    
    select
        id as order_id,
        user_id as customer_id,
        order_date,
        status

    from jaffle_shop.orders
)

select * from orders
