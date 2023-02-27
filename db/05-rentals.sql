\c nc_flix

CREATE TABLE rentals 
(
    rental_id SERIAL PRIMARY KEY,
    stock_id INT REFERENCES stock(stock_id),
    rental_start DATE,
    rental_end DATE,
    customer_id INT REFERENCES customers(customer_id)
);


INSERT INTO rentals
    (stock_id, rental_start, rental_end, customer_id)
VALUES
    (1, '2023-02-27', '2023-03-10', 1),
    (2, '2023-03-01', '2023-03-10', 2),
    (3, '2023-02-26', '2023-03-10', 3),
    (4, '2023-02-28', '2023-03-10', 4),
    (1, '2023-03-10', '2023-03-24', 5),
    (1, '2023-02-10', '2023-02-24', 5),
    (1, '2023-01-10', '2021-03-24', 5),
    (1, '2022-12-10', '2022-12-24', 5),
    (1, '2022-11-10', '2022-11-24', 5);

-- Using Leeds as Birmingham has no movies rated 'U'
WITH pop AS (
    SELECT COUNT(movie_id) AS title_count, movie_id FROM rentals
    JOIN stock USING (stock_id)
    JOIN movies USING (movie_id)
    GROUP BY movie_id)
SELECT DISTINCT(title), 
       CASE
         WHEN classification = 'U' THEN 'yes'
         ELSE 'no'
        END AS age_appropriate,
       CASE
         WHEN city = 'Leeds' THEN 'yes'
         ELSE 'no'
        END AS in_stock_nearby,
       CASE
         WHEN title_count > 5 THEN 'No'
         ELSE 'yes'
         END AS not_too_mainstream
FROM movies
LEFT JOIN stock USING (movie_id)
LEFT JOIN stores USING (store_id)
LEFT JOIN pop USING (movie_id)
ORDER BY title;