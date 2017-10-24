defmodule Discounters.DefaultDiscounterTest do
  use ExUnit.Case
  doctest Discounters.DefaultDiscounter

  import Discounters.DefaultDiscounter, only: [
    perform_discount: 1
  ]

  test "should calculate the total amount without discount" do
    product = %Product{
      price: 7.5,
      code: "MUG"
    }
    assert perform_discount([product, product, product]) == 7.5 * 3
    assert perform_discount([]) == 0
  end
end
