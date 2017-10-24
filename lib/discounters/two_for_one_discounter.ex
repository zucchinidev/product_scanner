defmodule Discounters.TwoForOneDiscounter do
  @moduledoc """
  This module performs operations to realize the discount two by one.
  """

  @doc """
  Applies the discount two for one to the list of products
    ## Examples

    iex> Discounters.TwoForOneDiscounter.perform_discount([%Product{code: "VOUCHER", price: 5}], %{base_price: 5})
    5
  """
  def perform_discount(products, price_rule) do
    products
      |> get_total(price_rule)
  end

  defp get_total([], _price_rule), do: 0
  defp get_total(products, price_rule) do
    base_price = price_rule.base_price
    total_units = length(products)
    base_price * div(total_units, 2) + base_price * rem(total_units, 2)
  end
end
