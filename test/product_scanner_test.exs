defmodule ProductScannerTest do
  use ExUnit.Case
  doctest ProductScanner

  import ProductScanner, only: [
    scan: 1,
    init: 0
  ]

  setup do
    {:ok, Map.from_struct(init())}
  end

  test "should have modules to apply discounts", %{discounters: discounters} do
    assert is_map(discounters)
    assert is_atom(discounters.default)
    assert function_exported?(discounters.default, :perform_discount, 1)
  end

  test "should allow a scan a product" do
    product = "fake_product"
    assert scan(product) == product
  end

  test "should throw an error when the product inserted is not valid" do
    invalid_products = ["", nil]
    invalid_products |> Enum.each(fn product ->
      assert_raise ArgumentError, fn ->
        scan(product)
      end
    end)
  end
end
