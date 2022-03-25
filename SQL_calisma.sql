SELECT A.product_id, A.product_name, B.category_id, B.category_name
FROM production.products AS A
INNER JOIN production.categories AS B
ON A.category_id = B.category_id;



--2. WAY
SELECT A.product_id, A.product_name, B.category_name, B.category_id
FROM production.products A, production.categories B
WHERE A.category_id = B.category_id


-- List store employees with their store information
-- Select employee name, surname, store names


SELECT B.first_name, B.last_name, A.store_name
FROM sales.stores A
INNER JOIN sales.staffs B
ON A.store_id = B.store_id

-- List the products with their category names.
-- Select product ID, product name, category name, and categoryID

-- 1. WAY
SELECT A.product_id, A.product_name, B.category_name, B.category_id
FROM production.products AS A
LEFT JOIN production.categories AS B
ON A.category_id = B.category_id
-- 2. WAY
-- Without allias
SELECT production.products.product_id, production.products.product_name,  production.categories.category_name, production.categories.category_id
FROM production.products
LEFT JOIN production.categories
ON production.products.category_id = production.categories.category_id




SELECT A.product_id, A.product_name, B.store_id, B.quantity
FROM production.products A
LEFT JOIN production.stocks B
ON A.product_id = B.product_id
WHERE A.product_id<50;

---RIGHT JOIN
SELECT PP.product_id, PP.product_name, PS.store_id, PS.quantity
FROM production.products AS PP
RIGHT JOIN production.stocks AS PS
ON PP.product_id = PS.product_id
WHERE PP.product_id > 310;

---Report the orders information made by all staffs.
--Expected columns: Staff_id, first_name, last_name, all the information about orders

SELECT A.staff_id, A.first_name,A.last_name, B.*
FROM sales.staffs A
RIGHT JOIN sales.orders B
ON A.staff_id = B.staff_id;


--Write a query that returns stock and order information together for all products .
----Expected columns: Product_id, store_id, quantity, order_id, list_price

SELECT A.product_id, B.store_id, B.quantity, A.order_id, A.list_price, B.product_id
FROM sales.order_items A
FULL OUTER JOIN production.stocks B
ON A.product_id = B.product_id;



SELECT EMIR.product_id, HAN.store_id, HAN.quantity, EMIR.product_id, EMIR.list_price, EMIR.order_id
FROM sales.order_items AS EMIR
FULL OUTER JOIN production.stocks AS HAN
ON EMIR.product_id = HAN.product_id;


--Write a query that returns all brand x category possibilities.
--Expected columns: brand_id, brand_name, category_id, category_name

SELECT *
FROM production.brands AS A
CROSS JOIN production.categories B;

SELECT A.brand_id, A.brand_name, B.category_id, B.category_name
FROM production.brands AS A
CROSS JOIN production.categories AS B;
-- THERE IS NO "ON" WITH CROSS JOIN




--Write a query that returns the table to be used to add products that are in the Products table but not in the stocks table to the stocks table with quantity = 0. 
--(Do not forget to add products to all stores.)
--Expected columns: store_id, product_id, quantity

SELECT*
FROM production.stocks;

SELECT*
FROM production.products;

SELECT*
FROM production.products A
WHERE A.product_id NOT IN (SELECT product_id FROM production.stocks);

SELECT B.store_id, A.product_id,A.product_name,0 quantity
FROM production.products A
CROSS JOIN sales.stores B
WHERE A.product_id NOT IN (SELECT product_id FROM production.stocks)
ORDER BY A.product_id,B.store_id;






-- CROSS JOIN
-- Write a query that returns the table to be used to add products that are in the Products table but not in the stocks table to the stocks table with quantity = 0.
-- (Do not forget to add products to all stores.)
-- Expected columns: store_id, product_id, quantity
-- To understand question, let's check
SELECT *
FROM production.stocks
SELECT *
FROM production.products
-- As you can see some of products are not in the stocks table, now let's find:
-- Number of items not on stock list but on product list
SELECT *
FROM production.products AS A
WHERE A.product_id NOT IN (SELECT product_id FROM production.stocks);
-- We find which product_id in stores but not in stocks
SELECT B.store_id, A.product_id, A.product_name, 0 quantity
FROM production.products AS A
CROSS JOIN sales.stores AS B
WHERE A.product_id NOT IN (SELECT product_id FROM production.stocks);


SELECT *
FROM sales.staffs


select*
from product_id
where
























SELECT*
From production.products;


SELECT product_id, count(product_id) as unique_product_id
FROM production.products
GROUP BY product_id
having count(product_id)>1



--Write a query that returns category ids with
--a maximum list price above 4000 or a minimum list price below 500

SELECT category_id, MAX (list_price) as max_price, MIN (list_price) as min_price
from production.products
group by category_id
having MAX (list_price) > 4000 or MIN (list_price) < 500;



---Question 2:
---Find the average product prices of the brands.
---As a result of the query, the average prices should be displayed in descending order
--- aggregation function: Count, Sum, Max, Min, Average






SELECT A.brand_name, AVG(B.list_price) AS AVG_PRICE
FROM production.brands A
INNER JOIN production.products B
ON A.brand_id = B.brand_id
GROUP BY
		A.brand_name
ORDER BY
		AVG_PRICE DESC;

----Next Question: Write a query that returns BRANDS with an average product price of more than 1000.

Select B.brand_name,AVG(list_price) AS avg_list_price
from production.products A
Join production.brands B
ON A.brand_id = B.brand_id
GROUP BY B.brand_name
HAVING AVG(list_price) > 1000
ORDER BY avg_list_price ASC;



--Next Question: Write a query that returns the net price paid by the customer for each order.
--(Don’t neglect discounts and quantities)


SELECT*
FROM sales.order_items

SELECT order_id, SUM((quantity * list_price * (1-discount)) AS NET_VALUE
FROM sales.order_items
GROUP BY order_id
ORDER BY order_id;



SELECT A.order_id, SUM(quantity * list_price * (1-discount)) AS net_value -- (1-discount) for percentile
FROM sales.order_items AS A
GROUP BY A.order_id

---or
SELECT order_id, SUM(quantity * (list_price-list_price*discount)) AS net_value -- (1-discount) for percentile
FROM sales.order_items
GROUP BY order_id



SELECT b.brand_name AS brand, c.category_name AS category, p.model_year,
     ROUND (SUM (quantity * i.list_price * (1 - discount)) , 0 ) total_sales_price
INTO sales.sales_summary1
FROM
sales.order_items i
INNER JOIN production.products p ON p.product_id = i.product_id
INNER JOIN production.brands b ON b.brand_id = p.brand_id
INNER JOIN production.categories c ON c.category_id = p.category_id
GROUP BY
    b.brand_name,
    c.category_name,
    p.model_year

SELECT brand,category,model_year,total_sales_price
FROM sales.sales_summary1
order by 1,2,3


---1.find the total sales price
-- 1. Total Sales (grouping by Brand)
SELECT SUM(total_sales_price) as sum_of_total_sales_price
FROM sales.sales_summary1
GROUP BY Brand


---or
SELECT sum (total_sales_price)
from sales.sales_summary1


--2.calculate the total sales price of the brands
select brand, sum(total_sales_price) as total_price
from sales.sales_summary1
group by brand 

--3.calculate the total sales price of the categories
select category, sum(total_sales_price) as total_price
from sales.sales_summary1
group by category

--4calculate the total price of sales by brand and category

SELECT category, brand, SUM(total_sales_price) as total_price
FROM sales.sales_summary1
GROUP BY Brand, Category


----ROLL UP
--- calculate the total sales by brand, category, model_year with roll up
--- three columns makes 4 different grouping combinations

SELECT Brand, Category, SUM(total_sales_price)
FROM sales.sales_summary
GROUP BY Brand, Category

select brand,category,model_year,sum(total_sales_price)



------cube------
--- calculate the total sales by brand, category, model_year with cube
--- three columns makes 8 different grouping combinations

SELECT brand, category, model_year, sum(total_sales_price)
from sales.sales_summary1
group by 
		cube(brand, category, model_year)
order by brand, category 
---or you can write order by 1,2




from sales.sales_summary1
group by
	ROLLUP (brand,category,model_year)
ORDER BY model_year,category


















































































