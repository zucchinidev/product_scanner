defmodule Discounters.ThreeOrMoreDiscounter do
  @moduledoc """
  This module performs operations to realize the discount two by one.
  """

  @doc """
  Applies the discount two for one to the list of products
    ## Examples

    iex> Discounters.ThreeOrMoreDiscounter.perform_discount([%Product{code: "TSHIRT", price: 20}])
    20
  """
  def perform_discount(products) do
    length(products) |> get_total()
  end

  defp get_total(total_units) when total_units >= 3 do
    base_price = 19
    base_price * total_units
  end
  defp get_total(total_units) do
    base_price = 20
    base_price * total_units
  end
end
