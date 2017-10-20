defmodule ProductScanner do
  @moduledoc """
  Documentation for ProductScanner.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ProductScanner.scan("VOUCHER")
      "VOUCHER"

  """
  def scan(product_name) when product_name == "" or product_name == nil do
    raise ArgumentError, message: "invalid argument, you must insert a valid product"
  end
  def scan(product_name) do
    product_name
  end
end
