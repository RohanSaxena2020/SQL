# What is the percentage of unique product increase in 2021 vs. 2020? 

-- The final output contains these fields,
-- unique_products_2020 unique_products_2021 percentage_chg

# how many unique products in 2020

# how many unique products in 2021

# (2021/2020)*100/2020 % 

SELECT count(distinct product_code) FROM fact_sales_monthly;  #347 unique products in total

with 
	cte1 as (SELECT count(distinct product_code) as unique_products_2020
				FROM fact_sales_monthly
				WHERE fiscal_year = 2020), #245
	cte2 as (SELECT count(distinct product_code) as unique_products_2021
				FROM fact_sales_monthly
				WHERE fiscal_year = 2021) #334
SELECT 
	unique_products_2020, 
    unique_products_2021,
    ROUND((unique_products_2021-unique_products_2020)*100/unique_products_2020,2) as percentage_chg
FROM cte1, cte2;
