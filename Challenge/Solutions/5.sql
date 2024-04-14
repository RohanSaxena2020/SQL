-- Get the products that have the highest and lowest manufacturing costs. 

-- The final output should contain these fields,
-- product_code,product,manufacturing_cost

with cte1 as (
	SELECT
		p.product_code,
		p.product,
		p.variant,
		ROUND(m.manufacturing_cost,2) as manufacturing_cost
	FROM dim_product p
	JOIN fact_manufacturing_cost m
		ON p.product_code = m.product_code
	WHERE 
		m.cost_year=2021 #I am using the most recent year since that is the most accurate cost
	ORDER BY m.manufacturing_cost DESC)
SELECT
	*
FROM cte1
WHERE
	manufacturing_cost = (SELECT MIN(manufacturing_cost) FROM cte1)
    OR manufacturing_cost = (SELECT MAX(manufacturing_cost) FROM cte1)
ORDER BY manufacturing_cost DESC
LIMIT 2; 