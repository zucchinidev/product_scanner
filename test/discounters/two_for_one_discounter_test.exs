defmodule Discounters.TwoForOneDiscounterTest do
  use ExUnit.Case
  doctest Discounters.TwoForOneDiscounter
  alias Discounters.DiscountRules

  import Discounters.TwoForOneDiscounter, only: [
    perform_discount: 2
  ]

  test "should calculate the total amount with discount" do
    product = %Product{
      price: 5,
      code: "VOUCHER"
    }
    price_rule = DiscountRules.get_rules()[:two_for_one]
    assert perform_discount([product, product, product], price_rule) == 10
    assert perform_discount([product, product], price_rule) == 5
    assert perform_discount([product], price_rule) == 5
    assert perform_discount([product, product, product, product], price_rule) == 10
    assert perform_discount([],price_rule) == 0
  end
end
