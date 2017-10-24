defmodule CheckoutTest do
  use ExUnit.Case
  alias ProductScanner
  alias Discounters.DiscountsLoader
  alias Discounters.DiscountRules

  import Checkout, only: [
    calculate_total_amount: 1
  ]

  test "should calculate total amount of a list of scanned products" do
    assert function_exported?(Checkout, :calculate_total_amount, 1)
    {:ok, pid} = ProductScanner.StateCreator.create() |> ProductScanner.start_link()
    state = get_state()
    test_cases = get_test_cases()
    Enum.each(test_cases, fn t ->
      Enum.each(t.scan_products, fn product -> ProductScanner.scan(pid, product) end)
      state = Map.put(state, :scanned_products, ProductScanner.get_scanned_products(pid))
      assert calculate_total_amount(state) == t.result
      ProductScanner.remove_scanned_products(pid)
    end)
  end

  defp get_state do
    %Checkout{
      available_discounters: DiscountsLoader.available_discounters(),
      price_rules: DiscountRules.get_rules()
    }
  end

  defp get_test_cases do
    [
      %{scan_products: [], result: 0},
      %{scan_products: ["VOUCHER", "VOUCHER", "VOUCHER"], result: 10},
      %{scan_products: ["VOUCHER", "TSHIRT", "MUG"], result: 32.50},
      %{scan_products: ["VOUCHER", "TSHIRT", "VOUCHER"], result: 25},
      %{scan_products: ["TSHIRT", "TSHIRT", "TSHIRT", "VOUCHER", "TSHIRT"], result: 81},
      %{scan_products: ["VOUCHER", "TSHIRT", "VOUCHER", "VOUCHER", "MUG", "TSHIRT", "TSHIRT"], result: 74.50}
    ]
  end
end
