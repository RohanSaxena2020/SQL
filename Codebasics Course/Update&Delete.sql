SET sql_safe_updates = 0;
UPDATE movies
SET studio="Warner Bros. Pictures",language_id=5
WHERE title LIKE "%Inception%";
SET sql_safe_updates = 1;

-- when you do this, make sure to run a SELECT query first to see what you're updating
-- SELECT * FROM movies WHERE title LIKE "%Inception%";

SELECT * FROM movies WHERE title LIKE "%Inception%";

DELETE FROM movies WHERE movie_id=146;