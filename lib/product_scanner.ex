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
  def scan(product_name) do
    is_valid = Enum.all?(valid_product_rules(product_name))
    case is_valid do
      true -> product_name
      _ -> raise ArgumentError, message: "invalid argument, you must insert a valid product"
    end
  end

  defp valid_product_rules(product_name) do
    [
      product_not_nil(product_name),
      product_not_empty(product_name)
    ]
  end

  defp product_not_nil(product), do: product != nil

  defp product_not_empty(product), do: product != ""
end
