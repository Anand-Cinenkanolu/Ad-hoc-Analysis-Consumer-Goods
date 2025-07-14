-- Requests 1 :

-- Atliq Exclusive APAC region.

SELECT 
*
from dim_customer
WHERE customer = 'Atliq Exclusive' and region = "APAC";

-- Requests 2 :

-- unique product increase % in 2021 vs. 2020


WITH cte1 as(
SELECT
COUNT(DISTINCT product_code) AS unique_product_2020
FROM fact_sales_monthly
where fiscal_year = 2020
),
cte2 AS(
SELECT
COUNT(DISTINCT product_code) AS unique_product_2021
FROM fact_sales_monthly
where fiscal_year = 2021
)
SELECT 
	unique_product_2020,
    unique_product_2021,
    (unique_product_2021 - unique_product_2020) * 100 / unique_product_2020 AS pct_chg
FROM cte1 c1
JOIN cte2 c2;

-- Requests 3 :

-- all the unique product counts for each segment

SELECT 
	segment,
	count(DISTINCT product_code) product_code
FROM dim_product
GROUP BY segment
ORDER BY product_code DESC;

-- Requests 4 :

-- most increase in unique products segment in 2021 vs 2020 

WITH unique_products AS(
SELECT
	segment,
    COUNT(DISTINCT(CASE WHEN fiscal_year = 2020 THEN s.product_code END)) AS product_count_2020,
    COUNT(DISTINCT(CASE WHEN fiscal_year = 2021 THEN s.product_code END)) AS product_count_2021
FROM dim_product p
JOIN fact_sales_monthly s
	USING (product_code)
GROUP BY p.segment
    
)

SELECT 
*,
	product_count_2021 - product_count_2020 AS difference
FROM unique_products
order by difference desc;

-- Requests 5 :

-- highest and lowest manufacturing costs


(SELECT 
	p.product_code,
    p.product,
    m.manufacturing_cost
FROM fact_manufacturing_cost m
JOIN dim_product p
	USING(product_code)
ORDER BY m.manufacturing_cost DESC
LIMIT 1 )

UNION 

(SELECT 
	p.product_code,
    p.product,
    m.manufacturing_cost
FROM fact_manufacturing_cost m
JOIN dim_product p
	USING(product_code)
ORDER BY m.manufacturing_cost ASC
LIMIT 1 );

-- Requests 6 :

-- top 5 customers who received an average high pre_invoice_discount_pct in 2021


WITH CTE1 AS(

SELECT 
	*
FROM fact_pre_invoice_deductions 
JOIN dim_customer c
USING (customer_code)
WHERE 
	fiscal_year = 2021 and
	c.market = 'India'
)

SELECT 
	customer_code,
    customer,
	concat(round(avg(pre_invoice_discount_pct) * 100 , 2), ' %') as average_discount_percentage
FROM CTE1
WHERE 
	fiscal_year = 2021 and
	market = "India"
GROUP BY customer_code, customer
ORDER BY avg(pre_invoice_discount_pct) * 100 DESC
LIMIT 5;

-- Requests 7 :

-- Atliq Exclusive each month analysis

SELECT
	MONTHNAME(s.date) AS month,
    s.fiscal_year AS year,
    sum(gross_price * sold_quantity) AS gross_sales
FROM fact_sales_monthly s
JOIN dim_customer c
	USING (customer_code)
JOIN fact_gross_price g 
	USING (product_code)
WHERE c.customer = 'Atliq Exclusive'
GROUP BY month, year
ORDER BY year ASC;

-- Requests 8 :

-- In which quarter of 2020, got the maximum total_sold_quantity


SELECT (
		CASE 
			WHEN month(date) IN (9, 10, 11) THEN	"Q1"
			WHEN month(date) IN (12, 1, 2) 	THEN 	"Q2"
			WHEN month(date) IN (3, 4, 5) 	THEN 	"Q3"
			WHEN month(date) IN (6, 7, 8) 	THEN 	"Q4"
			END) quarter,
    SUM(sold_quantity) as total_sold_qty
FROM fact_sales_monthly
where fiscal_year = 2020 
GROUP BY quarter
ORDER BY total_sold_qty DESC;

-- Requests 9 :

-- Which channel helped to bring more gross sales in the fiscal year 2021
-- and the percentage of contribution



WITH gross_sales_2021 AS (
SELECT 
    channel,
    round(sum(gross_price * sold_quantity) / 1000000 ,2) AS gross_sales_mln
    FROM 
        fact_sales_monthly s
    JOIN 
        fact_gross_price g 
        ON s.product_code = g.product_code 
    JOIN 
        dim_customer c 
        ON s.customer_code = c.customer_code
    WHERE 
        s.fiscal_year = 2021
    GROUP BY 
        c.channel
), 
s_total AS (
SELECT 
	sum(gross_sales_mln) as total
FROM gross_sales_2021)
SELECT 
	channel,
    gross_sales_mln,
    concat(round((gross_sales_mln / total) * 100,2), ' %') AS pct_contrubtion
FROM gross_sales_2021  
CROSS JOIN s_total 
ORDER BY gross_sales_mln desc;

-- Requests 10 :

--  Get the Top 3 products in each division that have a high
-- total_sold_quantity in the fiscal_year 2021



WITH cte1 as(
SELECT
	division,
    p.product_code,
    concat(p.product," (", p.variant,")") as product,
	sum(sold_quantity) AS total_sold_qty,
    RANK() OVER(PARTITION BY p.division ORDER BY sum(sold_quantity) DESC) AS rank_order
FROM fact_sales_monthly fs 
JOIN dim_product p 
ON p.product_code = fs.product_code
WHERE fiscal_year = 2021
GROUP BY fs.product_code, p.product, p.division
)
SELECT 
	*
FROM cte1
WHERE rank_order <= 3
ORDER BY division, rank_order ASC;




    
