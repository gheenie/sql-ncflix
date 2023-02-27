\c nc_flix


\echo '\n 1. The store with the highest total of sequels is:'

SELECT store_id, city, count(store_id) as count_stores
FROM movies 
JOIN stock 
USING (movie_id)
JOIN stores
USING (store_id)
WHERE title SIMILAR TO '%I( |I|II|V|X)%'
GROUP BY store_id, city
ORDER BY count_stores DESC
LIMIT 1;


\echo '\n 2. After altering movies table:'

ALTER TABLE movies
ADD COLUMN is_sequel BOOLEAN;

UPDATE movies
SET is_sequel = 'False';

WITH sequels AS (SELECT title
    FROM movies 
    WHERE title SIMILAR TO '%I( |I|II|V|X)%')
UPDATE movies
SET is_sequel = 'True'
WHERE title IN (SELECT title FROM sequels);

SELECT * from movies;
