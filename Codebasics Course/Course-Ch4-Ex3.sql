SELECT COUNT(*) as count FROM movies WHERE release_year BETWEEN 2015 AND 2022; 
SELECT MIN(release_year) as min_year, 
	MAX(release_year) as max_year FROM movies;
SELECT release_year, COUNT(*) as count 
FROM movies GROUP BY release_year 
ORDER BY release_year DESC;