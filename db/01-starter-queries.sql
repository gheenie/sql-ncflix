\c nc_flix

\echo '\n 1. Here are all the movie titles which were released in the 21st century:'

SELECT title 
FROM movies
WHERE release_date BETWEEN '2000-01-01' AND '2099-12-31';

\echo '\n 2. This is our oldest customer:'

SELECT * 
FROM customers
ORDER BY date_of_birth ASC
LIMIT 1;

\echo '\n 3. Customers beginning with D (youngest to oldest):'

SELECT * 
FROM customers
WHERE customer_name LIKE 'D%'
ORDER BY date_of_birth DESC;

\echo '\n 4. This is the average rating of the all the movies made in the 80s:'

SELECT AVG(rating) 
FROM movies
WHERE release_date BETWEEN '1980-01-01' AND '1989-12-31';

\echo '\n 5. These are the locations our customers live in, along with the total, and average number of loyalty points in that area.'

SELECT location, SUM(COALESCE(loyalty_points, 0)), AVG(COALESCE(loyalty_points, 0))
FROM customers
GROUP BY location;

\echo '\n 6. After decreasing the price of the movie rentals, the movie table now looks like:'

UPDATE movies
SET cost = ROUND(cost * 0.95, 2);




