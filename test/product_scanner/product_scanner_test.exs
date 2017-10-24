defmodule ProductScannerTest do
  use ExUnit.Case
  import ProductScanner, only: [
    start_link: 1,
    scan: 2,
    get_scanned_products: 1,
    remove_scanned_products: 1
  ]

  setup do
    {:ok, pid} = ProductScanner.StateCreator.create() |> start_link()
    {:ok, %{pid: pid}}
  end

  test "should allow a scan a product", %{pid: pid} do
    product = "VOUCHER"
    {:ok, _state} = scan(pid, product)
  end

  test "should verify if any product inserted is not valid", %{pid: pid} do
    invalid_products = ["", nil, "fake_product"]
    invalid_products |> Enum.each(fn product ->
      {:error, _msg} = scan(pid, product)
    end)
  end

  test "should return all scanned products", %{pid: pid} do
    products = ["TSHIRT", "MUG"]
    products |> Enum.each(fn product ->
      {:ok, _state} = scan(pid, product)
    end)
    assert get_scanned_products(pid) |> length() == 2
  end

  test "should return an empty list of scanned products", %{pid: pid} do
    products = ["TSHIRT", "MUG"]
    products |> Enum.each(fn product ->
      {:ok, _state} = scan(pid, product)
    end)
    assert remove_scanned_products(pid) == :ok
    assert get_scanned_products(pid) |> length() == 0
  end
end
