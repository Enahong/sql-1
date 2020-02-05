--
select count(*) from brands;
select count(*) from categories;
select count(*) from customers;
select count(*) from orders;
select count(*) from order_items;
select count(*) from products;
select count(*) from staffs;
select count(*) from stocks;
select count(*) from stores;

truncate table brands;
truncate table categories;
truncate table customers;
truncate table orders;
truncate table order_items;
truncate table products;
truncate table staffs;
truncate table stocks;
truncate table stores;



SELECT a.order_id, b.item_id
       ,b.product_id, d.product_name
       ,a.order_date
       ,a.shipped_date
       ,a.shipped_date - a.order_date πËº€¿œ 
       ,b.quantity 
       ,b.quantity * b.list_price order_amt
       ,e.brand_name
       ,f.category_name
       ,c.customer_id
       ,c.first_name || ' ' || c.last_name cust_name
       ,g.store_name
       ,h.first_name || ' ' || h.last_name staff_name
       ,g.city || ', ' || g.state
FROM ORDERS a,
     order_items b,
     customers c,
     products d,
     brands e,
     categories f,
     stores g,
     staffs h
where 1=1
and a.order_id = b.order_id     
and a.customer_id = c.customer_id
and b.product_id = d.product_id
and d.brand_id = e.brand_id
and d.category_id = f.category_id
and a.store_id = g.store_id
and a.staff_id = h.staff_id
order by 1, 2, 3
;




---------------------------------------------------------------------------------------

