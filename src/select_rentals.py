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
    rentals = [{column: row[i]
              for (i, column) in enumerate(columns)}
              for row in rows]

    print(rentals)

    query_str = '''SELECT store_id, city, COUNT(DISTINCT(movie_id)) as number_of_films
        FROM stores JOIN stock USING (store_id) GROUP BY store_id, city;'''

    rows = con.run(query_str)
    columns = [meta['name'] for meta in con.columns]
    rentals = [{column: row[i]
              for (i, column) in enumerate(columns)}
              for row in rows]

    print(rentals)

    query_str = '''SELECT store_id, city, COUNT(customer_id) as number_of_customers, COUNT(DISTINCT(movie_id)) as number_of_films 
        FROM rentals
        RIGHT JOIN stock USING (stock_id)
        RIGHT JOIN stores USING (store_id)
        RIGHT JOIN customers USING (customer_id)
        WHERE location = city
        GROUP BY store_id, city;'''

    rows = con.run(query_str)
    columns = [meta['name'] for meta in con.columns]
    rentals = [{column: row[i]
              for (i, column) in enumerate(columns)}
              for row in rows]

    print(rentals)

    return rentals
