import pg8000.native
from config._env_development import (user, password)


con = pg8000.native.Connection(
    user, password=password, database='nc_flix')


def select_movies(order_by='title', order='ASC', min_rating=-1):
    if order_by not in ['title', 'cost', 'rating', 'release_date']:
        raise Exception('Invalid order_by column')

    if order.upper() not in ['ASC', 'DESC']:
        raise Exception('Invalid sort order')

    query_str = f'SELECT * FROM movies WHERE COALESCE(rating,-1) >= {min_rating} ORDER BY {order_by} {order};'
    rows = con.run(query_str)
    columns = [meta['name'] for meta in con.columns]
    movies = [{column: row[i]
              for (i, column) in enumerate(columns)}
              for row in rows]
    con.close()
    return movies
