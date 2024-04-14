-- Get the complete report of the Gross sales amount for the 
-- customer “Atliq Exclusive” for each month. 
-- This analysis helps to get an idea of low and high-performing months 
-- and take strategic decisions.

-- The final report contains these columns: 
-- Month, Year, Gross sales Amount

# Gross Sales = sales volume * gross prices

WITH cte1 AS (
    SELECT 
        m.date,
        MONTH(m.date) as month,
        YEAR(m.date) as year,
        m.product_code,
        m.sold_quantity,
        m.fiscal_year,
        c.customer_code,
        c.customer
    FROM fact_sales_monthly m
    JOIN dim_customer c
        ON c.customer_code = m.customer_code
    WHERE c.customer = 'Atliq Exclusive'
    ORDER BY m.date
),
cte2 AS (
    SELECT
        cte1.date,
        cte1.month,
        cte1.year,
        cte1.product_code,
        cte1.sold_quantity,
        cte1.fiscal_year,
        cte1.customer_code,
        cte1.customer,
        p.gross_price,
        (cte1.sold_quantity * p.gross_price) as gross_sales_amount
    FROM cte1
    JOIN fact_gross_price p
        ON p.product_code = cte1.product_code
       AND p.fiscal_year = cte1.fiscal_year
)
SELECT
    cte2.month,
    cte2.year as calendar_year,
    ROUND(SUM(cte2.gross_sales_amount),2) as monthly_gross_sales
FROM cte2
GROUP BY cte2.month, cte2.year
ORDER BY cte2.year, cte2.month;

# I just had to chain them instead of doing nested