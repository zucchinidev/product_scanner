defmodule Discounters.DefaultDiscounterTest do
  use ExUnit.Case
  doctest Discounters.DefaultDiscounter
  alias Discounters.DiscountRules

  import Discounters.DefaultDiscounter, only: [
    perform_discount: 2
  ]

  test "should calculate the total amount without discount" do
    product = %Product{
      price: 7.5,
      code: "MUG"
    }
    price_rule = DiscountRules.get_rules()[:default]
    assert perform_discount([product, product, product], price_rule) == 7.5 * 3
    assert perform_discount([], price_rule) == 0
  end
end
