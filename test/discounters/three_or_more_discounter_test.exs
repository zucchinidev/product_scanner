defmodule Discounters.ThreeOrMoreDiscounterTest do
  use ExUnit.Case
  doctest Discounters.ThreeOrMoreDiscounter
  alias Discounters.DiscountRules

  import Discounters.ThreeOrMoreDiscounter, only: [
    perform_discount: 2
  ]

  test "should calculate the total amount with discount" do
    product = %Product{
      price: 20,
      code: "TSHIRT"
    }
    price_rule = DiscountRules.get_rules()[:three_or_more]
    assert perform_discount([product, product, product], price_rule) == 57
    assert perform_discount([product, product], price_rule) == 40
    assert perform_discount([product, product, product, product], price_rule) == 76
    assert perform_discount([], price_rule) == 0
  end
end
