defmodule Product.ValidScannedProductSpecificationTest do
  use ExUnit.Case
  doctest Product.ValidScannedProductSpecification

  import Product.ValidScannedProductSpecification, only: [
    is_satisfied_by: 2
  ]

  test "should check if a product is valid" do
    fake_product = "fake_product"
    product = %Product{
      code: "fake_product"
    }
    assert is_satisfied_by(fake_product, [product]) == true
  end

  test "should check if a product is not valid" do
    invalid_products = ["", nil]
    valid_product = %Product{
      code: "fake_product"
    }
    invalid_products |> Enum.each(fn product ->
      assert is_satisfied_by(product, [valid_product]) == false
    end)
  end
end
