\c nc_flix

\echo '\n 1. Here are the number of films in stock for each genre:'
SELECT genre_name, COUNT(genre_name) FROM stock
INNER JOIN movies USING (movie_id)
INNER JOIN movies_genres USING (movie_id)
INNER JOIN genres USING (genre_id)
GROUP BY genre_name;


\echo '\n 2. Here is the average rating for films in stock in Newcastle:'
SELECT AVG(rating) FROM movies
JOIN stock USING (movie_id)
JOIN stores USING (store_id)
WHERE city = 'Newcastle';


\echo '\n 3. Here are all the films made in 90s with above average rating:'
SELECT title, release_date, rating FROM movies
WHERE
    (release_date BETWEEN '1990-01-01' AND '1999-12-31') AND
    (rating > (SELECT AVG(rating) FROM movies));


\echo '\n 4. Here is the number of copies of the top rated film of the 5 most recently released films we have in stock across all stores:'

-- SELECT COUNT(movie_id) FROM stock
-- WHERE movie_id = 
--     (WITH top5 AS (SELECT movie_id, rating FROM movies
--         ORDER BY release_date DESC
--         LIMIT 5)
--     SELECT movie_id FROM top5
--     ORDER BY COALESCE(rating,0) DESC
--     LIMIT 1);

WITH top5 AS (SELECT movie_id, rating FROM movies
    ORDER BY release_date DESC
    LIMIT 5),
movie_id_top_rated as (
    SELECT movie_id FROM top5
    ORDER BY COALESCE(rating,0) DESC
    LIMIT 1)
SELECT COUNT(movie_id) FROM stock
WHERE movie_id = (select movie_id from movie_id_top_rated);


\echo '\n 5. These are the locations where our customers live which dont have stores:'
SELECT DISTINCT(location) FROM customers
WHERE location NOT IN
    (SELECT city FROM stores);


\echo '\n 6. These are all the locations which our business has influence over'
SELECT location FROM customers
UNION
SELECT city FROM stores;


\echo '\n 7a. This store has the highest quantity of stock:'

-- SELECT COUNT(stock_id), store_id FROM stock
-- WHERE store_id IN
--     (SELECT store_id FROM stores
--     WHERE city IN
--         (SELECT city FROM stores
--          INTERSECT
--          SELECT location FROM customers))
-- GROUP BY store_id
-- ORDER BY COUNT(stock_id) DESC
-- LIMIT 1;

WITH cities_with_nc_influence AS (SELECT city FROM stores
    INTERSECT
    SELECT location FROM customers),
stores_in_cities_with_nc_influence AS (SELECT store_id FROM stores
    WHERE city IN (SELECT city from cities_with_nc_influence))
SELECT COUNT(stock_id), store_id FROM stock
WHERE store_id IN (select store_id FROM stores_in_cities_with_nc_influence)
GROUP BY store_id
ORDER BY COUNT(stock_id) DESC
LIMIT 1;

\echo '\n 7b. ...and this is the most abundant genre in that store:'

-- SELECT COUNT(genre_name) AS count, genre_name FROM genres
-- JOIN movies_genres USING (genre_id)
-- JOIN movies USING (movie_id)
-- JOIN stock USING (movie_id)
-- WHERE store_id = 
--     (SELECT store_id FROM stock
--     WHERE store_id IN
--         (SELECT store_id FROM stores
--         WHERE city IN
--             (SELECT city FROM stores
--             INTERSECT
--             SELECT location FROM customers))
--     GROUP BY store_id
--     ORDER BY COUNT(stock_id) DESC
--     LIMIT 1)
-- GROUP BY genre_name
-- ORDER BY count DESC
-- LIMIT 1;

WITH cities_with_nc_influence AS (SELECT city FROM stores
    INTERSECT
    SELECT location FROM customers),
stores_in_cities_with_nc_influence AS (SELECT store_id FROM stores
    WHERE city IN (SELECT city from cities_with_nc_influence)),
store_id_with_biggest_nc_influence AS (SELECT store_id FROM stock
    WHERE store_id IN (select store_id FROM stores_in_cities_with_nc_influence)
    GROUP BY store_id
    ORDER BY COUNT(stock_id) DESC
    LIMIT 1)
SELECT COUNT(genre_name) AS count, genre_name FROM genres
JOIN movies_genres USING (genre_id)
JOIN movies USING (movie_id)
JOIN stock USING (movie_id)
WHERE store_id = (SELECT store_id FROM store_id_with_biggest_nc_influence)
GROUP BY genre_name
ORDER BY count DESC
LIMIT 1;
