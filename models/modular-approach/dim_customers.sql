-- Here we create some Tables. When running dbt run, file gets built, run AND tables are created in SF. 
-- BUT need to setup config block first if we want to have table
-- config block: say what we want. Here we'd like to create tables, but by DEFAULT VIEWs are created
{{
    config (
        materialized ='table'
    )
}}

-- REF: refer to other model ==> aka here we 'import' the customer model which we'll select on like table later
with customers as (

    select * from {{ ref('staging_cust')}}

),

orders as (

    select * from {{ ref('staging_order') }}

),

customer_orders as (

    select
        customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders

    from orders

    group by 1

),

final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders

    from customers

    left join customer_orders using (customer_id)

)

select * from final