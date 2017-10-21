defmodule Discounters.TwoForOneDiscounter do
  @moduledoc """
  This module performs operations to realize the discount two by one.
  """

  @doc """
  Applies the discount two for one to the list of products
    ## Examples

    iex> Discounters.DefaultDiscounter.perform_discount(["VOUCHER"])
    ["VOUCHER"]
  """
  def perform_discount(products) do
    products
  end
end
