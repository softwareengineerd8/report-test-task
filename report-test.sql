/*
Task 1:

Monthly Sales by Region (end point: http://localhost:8080/monthly-sales-by-region)
Group by: year, month, region_id
Show: total sales amount, number of orders
Must work for any 12-month period


Answer :

I have written the query which extracts the data as requested. 
This query will return the desired data for last 12 months

*/

SELECT YEAR(order_date) YEAR,MONTH(order_date) MONTH,region_id,sum(unit_price*quantity) total_sales_amount,count(order_id)number_of_orders FROM 
`orders` a 
join `products` b on a.product_id=b.product_id
join `stores` c on a.store_id=c.store_id
Where order_date >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
group by YEAR(order_date) ,MONTH(order_date),region_id;


/*

Task 2:

Top Categories by Store (end point: http://localhost:8080/top-categories-by-store)
Group by: store_id, category_id
Show: total sales amount, rank within store
Filtered by: date range (any 3 months)


This query will extract the data for last 3 months.
The rank is based on the number of quantity of a product sold.

*/

SELECT c.store_id,b.category_id,sum(unit_price*quantity) total_sales_amount, RANK() OVER (PARTITION BY store_id ORDER BY quantity DESC) AS   rank_within_store
FROM 
`orders` a 
join `products` b on a.product_id=b.product_id
join `stores` c on a.store_id=c.store_id
Where order_date >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
group by c.store_id,b.category_id;


/*

These Queries will be slow when the amount of data gets increased.

In Order Optimize the Queries. As this is related to Reporting so we need to denormalize a bit. 
and we add Region Id and Category_id in orders table.
Also we need to create index on the frequently used columns.


/*