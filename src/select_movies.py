from config.connection import con
from pg8000.native import literal


def select_movies(order_by='title', order='ASC', min_rating=-1, location=None):
    # Guarding against SQL injection

    if order_by not in ['title', 'cost', 'rating', 'release_date']:
        raise Exception('Invalid order_by column')

    if order.upper() not in ['ASC', 'DESC']:
        raise Exception('Invalid sort order')

    min_rating = literal(min_rating)

    # Building query string

    query_str = f'SELECT * FROM movies'

    if location != None:
        query_str += ' JOIN stock USING (movie_id) JOIN stores USING (store_id)'

    query_str += f' WHERE COALESCE(rating,-1) >= {min_rating}'

    if location != None:
        query_str += f' AND city = {literal(location)}'

    query_str += f' ORDER BY {order_by} {order};'

    # Run actual query

    rows = con.run(query_str)
    columns = [meta['name'] for meta in con.columns]
    movies = [
        {column: row[i] for (i, column) in enumerate(columns)} 
        for row in rows]
    
    return movies
