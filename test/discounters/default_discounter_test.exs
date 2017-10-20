defmodule ProductScanner.Discounters.DefaultDiscounterTest do
  use ExUnit.Case
  doctest ProductScanner.Discounters.DefaultDiscounter

  import ProductScanner.Discounters.DefaultDiscounter, only: [
    perform_discount: 1
  ]

  test "should allow return a list of products witout modify" do
    product = "fake_product"
    assert perform_discount([product]) == [product]
  end
end
