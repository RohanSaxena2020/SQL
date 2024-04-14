-- 8. In which quarter of 2020, got the maximum total_sold_quantity? 

-- The final output contains these fields sorted by the total_sold_quantity,
-- Quarter, total_sold_quantity

-- # this is the query I used to add fiscal_quarter as a column to fact_sales_monthly
-- ALTER TABLE gdb023.fact_sales_monthly
-- ADD COLUMN fiscal_quarter VARCHAR(2) GENERATED ALWAYS AS (
--     CASE 
--         WHEN MONTH(DATE_ADD(date, INTERVAL 4 MONTH)) BETWEEN 1 AND 3 THEN 'Q1'
--         WHEN MONTH(DATE_ADD(date, INTERVAL 4 MONTH)) BETWEEN 4 AND 6 THEN 'Q2'
--         WHEN MONTH(DATE_ADD(date, INTERVAL 4 MONTH)) BETWEEN 7 AND 9 THEN 'Q3'
--         WHEN MONTH(DATE_ADD(date, INTERVAL 4 MONTH)) BETWEEN 10 AND 12 THEN 'Q4'
--     END
-- ) AFTER fiscal_year;

SELECT 
	fiscal_quarter,
    SUM(sold_quantity) as total_sold_quantity
FROM fact_sales_monthly
WHERE fiscal_year=2020
GROUP BY fiscal_quarter
ORDER BY total_sold_quantity DESC;

SELECT 
	fiscal_quarter as fiscal_quarter_2020,
    SUM(sold_quantity) as total_sold_quantity
FROM fact_sales_monthly
GROUP BY fiscal_quarter
ORDER BY total_sold_quantity DESC;

