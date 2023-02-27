\c nc_flix


\echo '\n 1. Here is the information about the customers and their loyalty status:'

SELECT customer_name, location, 
    CASE 
        WHEN COALESCE(loyalty_points, 0) = 0 THEN 'doesn''t even go here'
        WHEN loyalty_points < 10 THEN 'bronze status'
        WHEN loyalty_points <= 100 THEN 'silver status'
        ELSE 'gold status'
    END
FROM customers;


\echo '\n 2. Here is a comprehensive output of the customers ordered by loyalty points, and grouped by area:'

select * from customers;

SELECT customer_name, AGE(date_of_birth), location, loyalty_points, 
    RANK() OVER (PARTITION BY location ORDER BY COALESCE(loyalty_points, 0) DESC) as ranking_within_location
FROM customers;
