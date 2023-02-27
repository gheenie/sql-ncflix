import pytest
from src.select_movies import (select_movies)


def test_length_of_list_equals_number_of_rows():
    result = select_movies()
    assert len(result) == 25


def test_returns_correct_keys():
    expected = ['movie_id', 'title', 'release_date',
                'rating', 'cost', 'classification', 'is_sequel']
    first_movie = select_movies()[0]
    assert list(first_movie.keys()) == expected


def test_returns_first_and_last_item_in_title_sorted_movie_list():
    movies = select_movies()
    first_movie = movies[0]
    assert first_movie['title'] == 'A Fish Called Wanda'
    last_movie = movies[-1]
    assert last_movie['title'] == 'Tron'


def test_returns_movie_list_sorted_by_release_date():
    movies = select_movies(order_by='release_date')
    first_date = movies[0]
    assert str(first_date['release_date']) == '1963-07-31'
    last_date = movies[-1]
    assert str(last_date['release_date']) == '2019-12-20'


def test_returns_movie_list_sorted_by_rating():
    movies = select_movies(order_by='rating')
    first_date = movies[0]
    assert first_date['rating'] == 1
    last_date = movies[-1]
    assert last_date['rating'] == None


def test_returns_movie_list_sorted_by_cost():
    movies = select_movies(order_by='cost')
    first_date = movies[0]
    assert float(first_date['cost']) == 0.95
    last_date = movies[-1]
    assert float(last_date['cost']) == 2.38


def test_raises_error_if_invalid_order_by_column():
    with pytest.raises(Exception) as e_info:
        select_movies(order_by='movie_id')
    assert e_info.value.args[0] == 'Invalid order_by column'


def test_by_returns_movie_list_sorted_in_descending_order():
    movies = select_movies(order='DESC')
    first_movie = movies[0]
    assert first_movie['title'] == 'Tron'
    last_movie = movies[-1]
    assert last_movie['title'] == 'A Fish Called Wanda'


def test_raises_error_if_invalid_order_column():
    with pytest.raises(Exception) as e_info:
        select_movies(order='INVALID_SORT_ORDER')
    assert e_info.value.args[0] == 'Invalid sort order'


def test_by_returns_movie_list_with_rating_greater_or_equal_than_min_rating():
    movies = select_movies(min_rating=6)
    assert len(movies) == 14
    first_movie = movies[0]
    assert first_movie['title'] == 'A Fish Called Wanda'
    last_movie = movies[-1]
    assert last_movie['title'] == 'Toy Story'
