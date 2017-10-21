defmodule ProductScanner.Product.ValidProductSpecification do
  @moduledoc """
  This module validate a product to see if it fulfils the set of rules of domain
  """

  @doc """
  Allows verification of the domain rules applied to the products
    ## Examples

    iex> ProductScanner.Product.ValidProductSpecification.is_satisfied_by("VOUCHER")
    true
  """
  def is_satisfied_by(product) do
    Enum.all?(valid_product_rules(product))
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
