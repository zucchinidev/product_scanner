defmodule Discounters.DefaultDiscounter do
  @moduledoc """
  Default discount handler. It will allow not to break the api of the discounters.
  Calculates the value of non-discounted products
  """

  @doc """
  Applies the discount defined by default in the list of products
    ## Examples

      iex> Discounters.DefaultDiscounter.perform_discount([%Product{price: 7.5, code: "MUG"}], %{discounted_price: 1})
      7.5
  """
  def perform_discount(products, nil) do
    products
    |> Enum.reduce(0, fn (product, acc) ->
      (acc + product.price)
    end)
  end
  def perform_discount(products, price_rule) do
    products
      |> Enum.reduce(0, fn (product, acc) ->
            (acc + product.price) * price_rule.discounted_price
         end)
  end
end
