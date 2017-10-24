defmodule Discounters.ThreeOrMoreDiscounter do
  @moduledoc """
  This module performs operations to realize the discount two by one.
  """

  @doc """
  Applies the discount two for one to the list of products
    ## Examples

    iex> Discounters.ThreeOrMoreDiscounter.perform_discount([%Product{code: "TSHIRT", price: 20}], %{discounted_price: 19, base_price: 20})
    20
  """
  def perform_discount(products, price_rule) do
    length(products) |> get_total(price_rule)
  end

  defp get_total(total_units, price_rule) when total_units >= 3 do
    price_rule.discounted_price * total_units
  end
  defp get_total(total_units, price_rule) do
    price_rule.base_price * total_units
  end
end
