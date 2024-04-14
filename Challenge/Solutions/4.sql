-- Follow-up: Which segment had the most increase in unique products in 2021 vs 2020? 

-- The final output contains these fields,
-- segment product_count_2020 product_count_2021 difference
 
with 
	cte1 as (SELECT 
					p.segment,
					COUNT(DISTINCT m.product_code) as product_count_2020
				FROM 
					fact_sales_monthly m
				JOIN 
					dim_product p ON m.product_code = p.product_code
				WHERE 
					m.fiscal_year = 2020
				GROUP BY 
					p.segment),
	cte2 as (SELECT 
					p.segment,
					COUNT(DISTINCT m.product_code) as product_count_2021
				FROM 
					fact_sales_monthly m
				JOIN 
					dim_product p ON m.product_code = p.product_code
				WHERE 
					m.fiscal_year = 2021
				GROUP BY 
					p.segment)
SELECT 
	cte1.segment,
    cte1.product_count_2020, 
    cte2.product_count_2021,
    (cte2.product_count_2021-cte1.product_count_2020) as difference
FROM 
	cte1
JOIN 
	cte2 ON cte1.segment = cte2.segment
ORDER BY difference DESC;