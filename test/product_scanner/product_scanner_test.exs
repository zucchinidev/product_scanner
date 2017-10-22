defmodule ProductScannerTest do
  use ExUnit.Case
  import ProductScanner, only: [
    start_link: 1,
    scan: 2,
    get_scanned_products: 1
  ]

  setup do
    {:ok, pid} = ProductScanner.StateCreator.create() |> start_link()
    {:ok, %{pid: pid}}
  end

  test "should allow a scan a product", %{pid: pid} do
    product = "fake_product"
    {:ok, _state} = scan(pid, product)
  end

  test "should verify if any product inserted is not valid", %{pid: pid} do
    invalid_products = ["", nil]
    invalid_products |> Enum.each(fn product ->
      {:error, _msg} = scan(pid, product)
    end)
  end

  test "should return all scanned products", %{pid: pid} do
    products = ["fake_product_one", "fake_product_two"]
    products |> Enum.each(fn product ->
      {:ok, _state} = scan(pid, product)
    end)
    assert get_scanned_products(pid) |> length() == 2
  end
end
