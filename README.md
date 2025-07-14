# Ad-hoc-Analysis-Consumer-Goods - SQL Portfolio Project

### Turning raw data into real business insights, one query at a time.

---

## 🚀 Project Summmery

AtliQ Hardwares is a fictional yet data-forward computer hardware company based in India with a global footprint. This project focuses on using structured SQL analysis to address key questions faced by business leadership.

---

## 🏢 About AtliQ Hardwares

A growing consumer electronics brand serving the APAC region. With rapid expansion and a diversified portfolio, they needed fast, data-backed insights to drive smarter decisions across teams.

---

## ❓ Business Ask

Management raised 10 high-priority questions related to:

- Market performance
- Product growth
- Customer behavior
- Sales and profitability trends

My role? Decode those into SQL logic, extract insights, and present them in boardroom-ready formats.

---

## 🌟 Deliverables

1. Wrote clean, efficient SQL queries for each business question
2. Interpreted results into plain-English insights
3. Created a visual insights deck for leadership
4. Added quick takeaways to help accelerate decisions

---

## 📂 Dataset Snapshot

| Table Name                    | Description                                      |
| ----------------------------- | ------------------------------------------------ |
| `dim_customer`                | Customer names, market, and channel              |
| `dim_product`                 | Product category, segment, division, launch year |
| `fact_sales_monthly`          | Monthly sold quantity and revenue per product    |
| `fact_gross_price`            | Price of each product at a given time            |
| `fact_manufacturing_cost`     | Production cost of each product                  |
| `fact_pre_invoice_deductions` | Discounts before invoicing for select customers  |

---

## 🧠 Insight Highlights

### 🔹 1. Where does our top customer operate in APAC?

💡 **Insight:** AtliQ Premium serves 8 major markets across the APAC region: **India, Indonesia, Japan, Philippines, South Korea, Australia, New Zealand, and Bangladesh.**

![**📊 Visualization**](https://github.com/Anand-Analyst-05/Ad-hoc-Analysis-Consumer-Goods/blob/main/Files/Query%20Output/Visual%201.png)

📌 **Query:** 
```sql
-- Requests 1 :

-- Atliq Exclusive APAC region.

SELECT 
*
from dim_customer
WHERE customer = 'Atliq Exclusive' and region = "APAC";
```

---

### 🔹 2. Product Growth YoY (2021 vs 2020)
💡 **Insight:** A 36% jump in product launches—clear signal of innovation.

![**📊 Visualization**](https://github.com/Anand-Analyst-05/Ad-hoc-Analysis-Consumer-Goods/blob/main/Files/Query%20Output/Visual%202.png)

📌 **Query:** 
```sql
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
```

---

### 🔹 3. Segment Dominance by Product Count
💡 **Insight:** Notebooks and Accessories dominate. Networking lags.

![**📊 Visualization**](https://github.com/Anand-Analyst-05/Ad-hoc-Analysis-Consumer-Goods/blob/main/Files/Query%20Output/Visual%203.png)

📌 **Query:** 
```sql
-- Requests 3 :

-- all the unique product counts for each segment

SELECT 
	segment,
	count(DISTINCT product_code) product_code
FROM dim_product
GROUP BY segment
ORDER BY product_code DESC;
```

---

### 🔹 4. Fastest Growing Product Segment
💡 **Insight:** Accessories had the sharpest growth YoY.

![**📊 Visualization**](https://github.com/Anand-Analyst-05/Ad-hoc-Analysis-Consumer-Goods/blob/main/Files/Query%20Output/Visual%204.png)

📌 **Query:** 
```sql
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
```

---

### 🔹 5. Highest vs Lowest Manufacturing Costs
💡 **Insight:** Product pricing is tiered. Cost range: $240.45 vs $0.89.

![**📊 Visualization**](https://github.com/Anand-Analyst-05/Ad-hoc-Analysis-Consumer-Goods/blob/main/Files/Query%20Output/Visual%205.png)

📌 **Query:** 
```sql
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
```

---

### 🔹 6. Top 5 Discounted Customers (FY21, India)
💡 **Insight:** Discounts are flat across top customers—equal treatment.

![**📊 Visualization**](https://github.com/Anand-Analyst-05/Ad-hoc-Analysis-Consumer-Goods/blob/main/Files/Query%20Output/Visual%206.png)

📌 **Query:** 
```sql
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
```

---

### 🔹 7. Monthly Gross Sales – AtliQ Premium
💡 **Insight:** FY21 saw a strong bounce back post-COVID.

![**📊 Visualization**](https://github.com/Anand-Analyst-05/Ad-hoc-Analysis-Consumer-Goods/blob/main/Files/Query%20Output/Visual%207.png)

📌 **Query:** 
```sql
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
```

---

### 🔹 8. Best Performing Quarter (2020)
**Insight:** Q1 leads in sales. Q3 dips due to likely logistics issues.
![**📊 Visualization**](https://github.com/Anand-Analyst-05/Ad-hoc-Analysis-Consumer-Goods/blob/main/Files/Query%20Output/Visual%208.png)

📌 **Query:** 
```sql
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
```

---

### 🔹 9. Channel Sales Performance (FY21)
💡 **Insight:** Retail dominates with 73% of gross sales.

![**📊 Visualization**](https://github.com/Anand-Analyst-05/Ad-hoc-Analysis-Consumer-Goods/blob/main/Files/Query%20Output/Visual%209.png)

📌 **Query:** 
```sql
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
```

---

### 🔹 10. Top Products by Division (FY21)
💡 **Insight:** Top-sellers differ by division—strategy should match.

![**📊 Visualization**](https://github.com/Anand-Analyst-05/Ad-hoc-Analysis-Consumer-Goods/blob/main/Files/Query%20Output/Visual%2010.png)

📌 **Query:** 
```sql
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
```

---

## 📋 Skills I Sharpened

### 💻 Technical
- SQL window functions, aggregates, CTEs
- Efficient JOINs, subqueries, Case Statement and Windows
- KPI-driven filtering and grouping
- Query performance optimization

### 📊 Analytical
- Insight prioritization
- Business context mapping
- Data-driven storytelling

### 🚨 Soft Skills
- Executive-level presentation
- Insight communication
- Visual thinking for non-technical audiences

---

## 📂 Repo Structure

```
📁 atliq-SQL-Insights/
👤📁 Ad-Hoc-Requests/     # SQL queries for each business question
📁 visuals/               # All supporting charts
📁 slides/                # Executive summary slides (PDF)
README.md
CREDITS.md
```

---

## 🔗 Links

- 🎥 [Power BI Live Dashboard](https://app.powerbi.com/view?r=eyJrIjoiMDNiYzdhMTgtYTgwMC00NjhmLWI3NmEtMjAwNzlkZjc0ZTQ0IiwidCI6ImM2ZTU0OWIzLTVmNDUtNDAzMi1hYWU5LWQ0MjQ0ZGM1YjJjNCJ9)
- 📌[Linkedin Post](https://codebasics.io/portfolio/Anand-Cinenkanolu)
- 📁[Portfolio](https://codebasics.io/portfolio/Anand-Cinenkanolu) 
- 📜 [Challenge Details](https://codebasics.io/project-challenge)

---

## 🌟 Closing Note

This project is a real look at how I analyze open-ended business questions using SQL and communicate them clearly. If you're hiring—or just curious about how data turns into decisions—feel free to ⭐ this repo and connect with me on [LinkedIn](https://www.linkedin.com/in/anand-cinenkanolu-data-analyst/)

Let’s build with data.

