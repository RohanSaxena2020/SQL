SELECT 
	m.title, f.revenue, f.currency, f.unit, l.name as language_name,
    CASE
		WHEN unit = "thousands" THEN ROUND (f.revenue/1000,2)
        WHEN unit = "millions" THEN ROUND(f.revenue,2)
        WHEN unit = "billions" THEN ROUND(f.revenue*1000,2)
	END as revenue_in_millions
FROM movies m
JOIN financials f USING (movie_id)
JOIN languages l USING (language_id)
WHERE l.name = "Hindi"
ORDER BY revenue_in_millions DESC;