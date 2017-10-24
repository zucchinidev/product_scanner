defmodule Discounters.DefaultDiscounter do
  @moduledoc """
  Default discount handler. It will allow not to break the api of the discounters.
  """

  @doc """
  Applies the discount defined by default in the list of products
    ## Examples

      iex> Discounters.DefaultDiscounter.perform_discount([%Product{price: 7.5, code: "MUG"}])
      7.5
  """
  def perform_discount(products) do
    products
      |> Enum.reduce(0, fn (product, acc) ->
          acc + product.price
         end)
  end
end
