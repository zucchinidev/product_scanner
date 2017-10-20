defmodule ProductScanner.Discounters.DefaultDiscounter do
  @moduledoc """
  Default discount handler. It will allow not to break the api of the discounters.
  """

  @doc """
  Applies the discount defined by default in the list of products
    ## Examples

      iex> ProductScanner.Discounters.DefaultDiscounter.perform_discount(["VOUCHER"])
      ["VOUCHER"]
  """
  def perform_discount([]), do: []
  def perform_discount([head | tail]), do: [head | tail]
end
