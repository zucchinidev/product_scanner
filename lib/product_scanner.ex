alias ProductScanner.Discounters.RegisterDiscounters
defmodule ProductScanner do
  @moduledoc """
  Documentation for ProductScanner.
  """
  alias __MODULE__, as: ProductScanner
  defstruct ~w(discounters)a

  @doc """
  Initialization of modules used
  """
  def init do
    %ProductScanner{
      discounters: RegisterDiscounters.available_discounters()
    }
  end

  @doc """
  Scan products in any order.

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
