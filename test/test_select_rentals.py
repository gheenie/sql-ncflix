import pytest
from src.select_rentals import (select_rentals)
from config.connection import con


def teardown_module():
    con.close()


def test_number_of_customers_property_is_correct_length():
    expected = 2

    cities_with_number_of_customers = select_rentals()['cities_with_number_of_customers']

    assert len(cities_with_number_of_customers) == expected


def test_number_of_customers_property_has_correct_columns():
    expected = ['store_id', 'city', 'number_of_customers']

    first_city_with_number_of_customers = select_rentals()['cities_with_number_of_customers'][0]

    assert list(first_city_with_number_of_customers.keys()) == expected


def test_number_of_films_property_is_correct_length():
    expected = 4

    cities_with_number_of_films = select_rentals()['cities_with_number_of_films']

    assert len(cities_with_number_of_films) == expected


def test_number_of_films_property_has_correct_columns():
    expected = ['store_id', 'city', 'number_of_films']

    first_city_with_number_of_films = select_rentals()['cities_with_number_of_films'][0]

    assert list(first_city_with_number_of_films.keys()) == expected
