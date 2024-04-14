-- Which channel helped to bring more gross sales in the fiscal year 2021 
-- and the percentage of contribution? 

-- The final output contains these fields,
-- channel,gross_sales_mln,percentage

SELECT
	DISTINCT channel
FROM dim_customer;

#step 1: get the channel

with cte1 as (
	SELECT 
		m.product_code,
        m.customer_code,
        m.sold_quantity,
        m.fiscal_year,
        c.customer,
        c.channel
	FROM fact_sales_monthly m
	JOIN dim_customer c
		ON m.customer_code = c.customer_code
	WHERE m.fiscal_year = 2021
    LIMIT 10000000
),
cte2 as (
	SELECT #step 2: add the price for the given fiscal year
		cte1.product_code,
        cte1.customer_code,
        cte1.sold_quantity,
        cte1.fiscal_year,
        cte1.customer,
        cte1.channel,
        p.gross_price,
        (cte1.sold_quantity * p.gross_price) as gross_sales_amount
	FROM cte1
	JOIN fact_gross_price p
		ON p.product_code = cte1.product_code
		AND p.fiscal_year = cte1.fiscal_year
)
SELECT
    cte2.channel,
    SUM(cte2.gross_sales_amount)/1000000 as total_gross_sales_mln,
    (SUM(cte2.gross_sales_amount) / SUM(SUM(cte2.gross_sales_amount)) OVER ()) * 100 AS percentage
FROM cte2
GROUP BY cte2.channel;