defmodule ProductScannerTest do
  use ExUnit.Case
  doctest ProductScanner

  import ProductScanner, only: [
    scan: 1
  ]

  test "should allow a scan to valid product" do
    product = "fake_product"
    assert scan(product) == product
  end

  test "should throw an ArgumentError when the product is nil or empty" do
    invalid_products = ["", nil]
    invalid_products |> Enum.each(fn product ->
      assert_raise ArgumentError, fn ->
        scan(product)
      end
    end)
  end
end
