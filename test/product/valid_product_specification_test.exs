defmodule Product.ValidProductSpecificationTest do
  use ExUnit.Case
  doctest Product.ValidProductSpecification

  import Product.ValidProductSpecification, only: [
    is_satisfied_by: 1
  ]

  test "should check if a product is valid" do
    product = "fake_product"
    assert is_satisfied_by(product) == true
  end

  test "should should check if a product is not valid" do
    invalid_products = ["", nil]
    invalid_products |> Enum.each(fn product ->
      assert is_satisfied_by(product) == false
    end)
  end
end
