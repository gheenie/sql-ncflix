import pytest
from src.select_movies import (select_rentals)
from config.connection import con


def teardown_module():
    con.close()


def test_select_rentals_returns_correct_columns():
    expected = ['store_id', 'city', 'number_of_customers']

    first_rental = select_rentals()[0]

    assert list(first_rental.keys()) == expected


def test_select_rentals_returns_correct_number_of_rows():
    expected = 2

    rentals = select_rentals()

    assert len(rentals) == expected
