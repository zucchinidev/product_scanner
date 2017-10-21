defmodule Discounters.TwoForOneDiscounterTest do
  use ExUnit.Case
  doctest Discounters.TwoForOneDiscounter

  import Discounters.TwoForOneDiscounter, only: [
    perform_discount: 1
  ]

  test "should allow return a list of products witout modify" do
    product = "fake_product"
    assert perform_discount([product]) == [product]
  end
end
