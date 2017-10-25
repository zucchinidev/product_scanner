# ProductScanner

**TODO: Add description**

## Getting Started

To start the scanner you can use:

```
{:ok, pid} = ProductScanner.StateCreator.create() |> ProductScanner.start_link()

Enum.each(["VOUCHER", "TSHIRT", "MUG"], fn product -> ProductScanner.scan(pid, product) end)

state = %Checkout{
              available_discounters: DiscountsLoader.available_discounters(),
              price_rules: DiscountRules.get_rules(),
              scanned_products: ProductScanner.get_scanned_products(pid)
            }

Checkout.calculate_total_amount(state) // 32.50
```

Documentation can be generated with:
```
mix docs
```

## Test Cases
```elixir
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

#  Finished in 0.2 seconds
#  22 tests, 0 failures

```
## Contributions

If you do make changes to the codebase, please make sure you test your changes thoroughly, and include any unit tests alongside new or changed behaviours.

$ mix test