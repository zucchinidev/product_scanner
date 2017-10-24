defmodule Discounters.ThreeOrMoreDiscounterTest do
  use ExUnit.Case
  doctest Discounters.ThreeOrMoreDiscounter

  import Discounters.ThreeOrMoreDiscounter, only: [
    perform_discount: 1
  ]

  test "should calculate the total amount with discount" do
    product = %Product{
      price: 20,
      code: "TSHIRT"
    }
    assert perform_discount([product, product, product]) == 57
    assert perform_discount([product, product]) == 40
    assert perform_discount([product, product, product, product]) == 76
    assert perform_discount([]) == 0
  end
end
