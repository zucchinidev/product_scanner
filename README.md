# ProductScanner

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `product_scanner` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:product_scanner, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/product_scanner](https://hexdocs.pm/product_scanner).

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