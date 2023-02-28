from config.connection import con


def select_rentals():
    query_str = '''SELECT store_id, city, COUNT(customer_id) as number_of_customers
         FROM rentals
         JOIN stock USING (stock_id)
         JOIN stores USING (store_id)
         JOIN customers USING (customer_id)
         WHERE location = city
         GROUP BY store_id, city;'''

    rows = con.run(query_str)
    columns = [meta['name'] for meta in con.columns]
    cities_with_number_of_customers = [{column: row[i]
        for (i, column) in enumerate(columns)}
        for row in rows]

    query_str = '''SELECT store_id, city, COUNT(DISTINCT(movie_id)) as number_of_films
         FROM stores
         JOIN stock
         USING (store_id)
         GROUP BY store_id, city;'''

    rows = con.run(query_str)
    columns = [meta['name'] for meta in con.columns]
    cities_with_number_of_films = [{column: row[i]
        for (i, column) in enumerate(columns)}
        for row in rows]

    return {
        'cities_with_number_of_customers': cities_with_number_of_customers, 
        'cities_with_number_of_films': cities_with_number_of_films
    }
