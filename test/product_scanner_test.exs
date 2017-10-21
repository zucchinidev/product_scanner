defmodule ProductScannerTest do
  use ExUnit.Case

  import ProductScanner, only: [
    start_link: 0,
    scan: 2
  ]

  test "should have modules to apply discounts" do
    {:ok, pid} = start_link()
    %ProductScanner{discounters: discounters} = :sys.get_state(pid)

    assert is_map(discounters)
    assert is_atom(discounters.default)
    assert function_exported?(discounters.default, :perform_discount, 1)
  end

  test "should allow a scan a product" do
    {:ok, pid} = start_link()
    product = "fake_product"
    {:ok, _state} = scan(pid, product)
  end

  test "should verify if any product inserted is not valid" do
    {:ok, pid} = start_link()
    invalid_products = ["", nil]
    invalid_products |> Enum.each(fn product ->
      {:error, _msg} = scan(pid, product)
    end)
  end
end
