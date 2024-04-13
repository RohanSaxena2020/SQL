SELECT m.movie_id, m.title, m.language_id, l.name
FROM movies m
JOIN languages l
ON m.language_id = l.language_id;

SELECT m.movie_id, m.title, m.language_id, l.name
FROM movies m
JOIN languages l
ON m.language_id = l.language_id
WHERE l.name="Telugu";

SELECT l.name, COUNT(m.movie_id) as count
FROM languages l
LEFT JOIN movies m USING (language_id)
GROUP BY language_id
ORDER BY count DESC;
