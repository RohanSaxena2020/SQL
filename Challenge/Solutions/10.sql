-- Get the Top 3 products in each division that have a high total_sold_quantity 
-- in the fiscal_year 2021? 
-- The final output contains these fields,
-- division,product_code,product,total_sold_quantity,rank_order

# I chose DENSE_RANK() since I want to see the top 3 even if there are ties.

with cte1 as (
		SELECT
			m.product_code,
            SUM(m.sold_quantity) as total_sold_quantity
		FROM fact_sales_monthly m
		WHERE fiscal_year=2021
		GROUP BY m.product_code),
 
	cte2 as (
		SELECT
			p.division,
			cte1.product_code,
			p.product,
			cte1.total_sold_quantity,
			DENSE_RANK() OVER (PARTITION BY p.division ORDER BY cte1.total_sold_quantity DESC) as rank_order
		FROM cte1
		JOIN dim_product p
			ON cte1.product_code=p.product_code)
SELECT
	*
FROM cte2
WHERE rank_order<= 3;