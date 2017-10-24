defmodule Discounters.TwoForOneDiscounterTest do
  use ExUnit.Case
  doctest Discounters.TwoForOneDiscounter

  import Discounters.TwoForOneDiscounter, only: [
    perform_discount: 1
  ]

  test "should calculate the total amount with discount" do
    product = %Product{
      price: 5,
      code: "VOUCHER"
    }
    assert perform_discount([product, product, product]) == 10
    assert perform_discount([product, product]) == 5
    assert perform_discount([product]) == 5
    assert perform_discount([product, product, product, product]) == 10
  end
end
