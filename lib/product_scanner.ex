defmodule ProductScanner do
  @moduledoc """
  Documentation for ProductScanner.
  """
  alias __MODULE__, as: ProductScanner
  defstruct ~w(discounters)a
  alias ProductScanner.Discounters.RegisterDiscounters
  alias ProductScanner.Product.ValidProductSpecification

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
  def scan(product_name) do
    case ValidProductSpecification.is_satisfied_by(product_name) do
      true -> product_name
      _ -> raise ArgumentError, message: "invalid argument, you must insert a valid product"
    end
  end
end
