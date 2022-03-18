-- 1.What is the sales quantity of product/ according to the brands/ and sort them highest-lowest

SELECT sum(A.quantity) sum_of,C.brand_name
FROM sales.order_items A ,production.products B,production.brands C
WHERE A.product_id = B.product_id and B.brand_id = C.brand_id
group by brand_name
order by sum_of desc


--SELECT SUM(A.quantity) sum_of, C.brand_name
--FROM production.products AS B, sales.order_items A, production.brands C
--WHERE A.product_id = B.product_id AND B.brand_id = C.brand_id
--GROUP BY C.brand_name
--ORDER BY sum_of DESC

SELECT sum(A.quantity) sum_of, C.brand_name
FROM sales.order_items as A
INNER production.products as B
On A.product_id = B.product_id
INNER production.brands as C
ON B.brand_id = C.brand_id
GROUP BY C.brand_name
order by sum_of desc


----- 2. Select the top 5 most expensive products -- TOP 5
SELECT top 5 list_price, product_name
FROM production.products as pp
order by list_price desc

----- 3. What are the categories that each brand has
SELECT pb.brand_name, pc.category_name
FROM production.categories as pc, production.products as pp, production.brands as pb
WHERE pc.category_id = pp.category_id and pp.brand_id = pb.brand_id
Group by brand_name, category_name
order by brand_name

----- 4. Select the avg prices according to /brands and /categories
SELECT AVG(PP.list_prise) av_list_price, brands_name, category_name
FROM production.categories PC, production.products PP, production.brands PB
WHERE PC.category_id = PP.category_id AND PP.brand_id = PB.brand_id
Group by brands_name, category_name
order by av_list_price


----- Select the annual amount of product produced according to brands
SELECT*
WHERE production.products PP, production.brands PB, production.stoks PS
FROM













