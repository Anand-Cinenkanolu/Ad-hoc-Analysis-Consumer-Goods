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
**Insight:** AtliQ Premium serves 8 major markets across Asia-Pacific.

:arrow_left: [SQL File](./Ad-Hoc-Requests/01-market-coverage.sql) | 📸 [Chart](./visuals/market-coverage.png)

---

### 🔹 2. Product Growth YoY (2021 vs 2020)
**Insight:** A 36% jump in product launches—clear signal of innovation.

:arrow_left: [SQL File](./Ad-Hoc-Requests/02-product-growth.sql) | 📸 [Chart](./visuals/product-growth.png)

---

### 🔹 3. Segment Dominance by Product Count
**Insight:** Notebooks and Accessories dominate. Networking lags.

:arrow_left: [SQL File](./Ad-Hoc-Requests/03-segment-ranking.sql) | 📸 [Chart](./visuals/segment-ranking.png)

---

### 🔹 4. Fastest Growing Product Segment
**Insight:** Accessories had the sharpest growth YoY.

:arrow_left: [SQL File](./Ad-Hoc-Requests/04-growth-segment.sql) | 📸 [Chart](./visuals/segment-growth.png)

---

### 🔹 5. Highest vs Lowest Manufacturing Costs
**Insight:** Product pricing is tiered. Cost range: ₹240.53 vs ₹0.89.

:arrow_left: [SQL File](./Ad-Hoc-Requests/05-cost-variance.sql) | 📸 [Chart](./visuals/cost-comparison.png)

---

### 🔹 6. Top 5 Discounted Customers (FY21, India)
**Insight:** Discounts are flat across top customers—equal treatment.

:arrow_left: [SQL File](./Ad-Hoc-Requests/06-top-discounts.sql) | 📸 [Chart](./visuals/top-discounts.png)

---

### 🔹 7. Monthly Gross Sales – AtliQ Premium
**Insight:** FY21 saw a strong bounce back post-COVID.

:arrow_left: [SQL File](./Ad-Hoc-Requests/07-monthly-sales.sql) | 📸 [Chart](./visuals/monthly-sales.png)

---

### 🔹 8. Best Performing Quarter (2020)
**Insight:** Q1 leads in sales. Q3 dips due to likely logistics issues.

:arrow_left: [SQL File](./Ad-Hoc-Requests/08-quarter-performance.sql) | 📸 [Chart](./visuals/quarter-comparison.png)

---

### 🔹 9. Channel Sales Performance (FY21)
**Insight:** Retail dominates with 73% of gross sales.

:arrow_left: [SQL File](./Ad-Hoc-Requests/09-channel-share.sql) | 📸 [Chart](./visuals/channel-sales.png)

---

### 🔹 10. Top Products by Division (FY21)
**Insight:** Top-sellers differ by division—strategy should match.

:arrow_left: [SQL File](./Ad-Hoc-Requests/10-top-products.sql) | 📸 [Chart](./visuals/top-products.png)

---

## 📋 Skills I Sharpened

### 💻 Technical
- SQL window functions, aggregates, CTEs
- Efficient JOINs and subqueries
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

- 🎥 [Video Walkthrough](https://youtu.be/demo-link)
- 📊 [Project Slides](./slides/novatech-insights.pdf)
- 📜 [Challenge Details](https://codebasics.io/project-challenge)

---

## 🌟 Closing Note

This project is a real look at how I analyze open-ended business questions using SQL and communicate them clearly. If you're hiring—or just curious about how data turns into decisions—feel free to ⭐ this repo and connect with me on [LinkedIn](https://linkedin.com/in/yourname).

Let’s build with data.

