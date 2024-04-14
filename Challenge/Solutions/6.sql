-- Generate a report which contains the top 5 customers who received an average 
-- high pre_invoice_discount_pct for the fiscal year 2021 and in the Indian market. 

-- The final output contains these fields,
-- customer_code, customer, average_discount_percentage

SELECT
	c.customer_code,
    c.customer,
    Round((AVG(i.pre_invoice_discount_pct)*100),2) as average_discount_percentage #is the *100 necessary?
FROM dim_customer c
JOIN fact_pre_invoice_deductions i
	ON c.customer_code = i.customer_code
WHERE i.fiscal_year = 2021 AND c.market = 'India'
GROUP BY c.customer_code, c.customer
ORDER BY average_discount_percentage DESC
LIMIT 5;