with forecast_err_table_2020 as (
		SELECT
			s.customer_code,
			SUM((forecast_quantity-sold_quantity)) as net_err,
			SUM((forecast_quantity-sold_quantity))*100/SUM(forecast_quantity) as net_err_pct,
			SUM(ABS(forecast_quantity-sold_quantity)) as abs_err,
			SUM(ABS(forecast_quantity-sold_quantity))*100/SUM(forecast_quantity) as abs_err_pct
		FROM fact_act_est s
		WHERE s.fiscal_year=2020
		GROUP BY customer_code),
        
	forecast_err_table_2021 as (
		SELECT
				s.customer_code,
				SUM((forecast_quantity-sold_quantity)) as net_err,
				SUM((forecast_quantity-sold_quantity))*100/SUM(forecast_quantity) as net_err_pct,
				SUM(ABS(forecast_quantity-sold_quantity)) as abs_err,
				SUM(ABS(forecast_quantity-sold_quantity))*100/SUM(forecast_quantity) as abs_err_pct
			FROM fact_act_est s
			WHERE s.fiscal_year=2021
			GROUP BY customer_code)
SELECT
	e.customer_code,
    c.customer,
    c.market,
    if (e.abs_err_pct>100,0,100-(e.abs_err_pct)) as forecast_accuary_2020,
    if (e2.abs_err_pct>100,0,100-(e2.abs_err_pct)) as forecast_accuary_2021
FROM forecast_err_table_2020 e
JOIN dim_customer c
	USING (customer_code)
JOIN forecast_err_table_2021 e2
	USING (customer_code)
order by forecast_accuary_2020 desc;

-- SET SESSION sql_mode=(SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', '')); -> disable


-- SET SESSION sql_mode=CONCAT_WS(',', @@sql_mode, 'ONLY_FULL_GROUP_BY'); -> enable
