SELECT 
	*,
    (1 - pre_invoice_discount_pct) * gross_price_total as net_invoice_sales,
    (post.discounts_pct+post.other_deductions_pct) as post_invoice_discount_pct
FROM sales_preinv_discount s
JOIN fact_post_invoice_deductions post
	ON s.date = post.date
    AND s.product_code = post.product_code
    AND s.customer_code = post.customer_code