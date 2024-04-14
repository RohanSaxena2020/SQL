-- Provide a report with all the unique product counts for each segment 
-- and sort them in descending order of product counts. 

-- The final output contains 2 fields,
-- segment, product_count

# unique products

SELECT 
	segment,
    COUNT(DISTINCT product) as product_count
FROM dim_product
GROUP BY segment
ORDER BY product_count DESC;

#unique product codes (takes into account the variants)

SELECT 
	segment,
    COUNT(DISTINCT product_code) as product_count
FROM dim_product
GROUP BY segment
ORDER BY product_count DESC;

