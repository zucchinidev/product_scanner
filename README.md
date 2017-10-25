# ProductScanner

```
Code         | Name                |  Price
-------------------------------------------------
VOUCHER      | Voucher             |   5.00€
TSHIRT       | T-Shirt             |  20.00€
MUG          | Coffee Mug          |   7.50€
```


Various departments have insisted on the following discounts:

* The marketing department believes in 2-for-1 promotions (buy two of the same product, get one free), and would like for there to be a 2-for-1 special on VOUCHER items.

* The CFO insists that the best way to increase sales is with discounts on bulk purchases (buying x or more of a product, the price of that product is reduced), and demands that if you buy 3 or more TSHIRT items, the price per unit should be 19.00€.

The checkout process allows for items to be scanned in any order, and should return the total amount to be paid.

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