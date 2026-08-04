import pytest

from calculator import Calculator

calc = Calculator()


def test_add():

    assert calc.add(10, 20) == 30


def test_subtract():

    assert calc.subtract(20, 10) == 10


def test_multiply():

    assert calc.multiply(5, 4) == 20


def test_divide():

    assert calc.divide(20, 5) == 4


def test_divide_by_zero():

    with pytest.raises(ValueError):
        calc.divide(10, 0)