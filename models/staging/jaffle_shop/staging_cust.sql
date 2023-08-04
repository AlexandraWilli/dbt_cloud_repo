-- GET DATA FROM SOURCES and make raw data look the way you want (perform some basic tranformaitons if needed)
with customers as (
    
    select 
        id as customer_id,
        first_name,
        last_name

    from jaffle_shop.customers
)

select * from customers