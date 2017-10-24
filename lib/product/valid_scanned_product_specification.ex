defmodule Product.ValidScannedProductSpecification do
  @moduledoc """
  This module validate a product to see if it fulfils the set of rules of domain
  """

  @doc """
  Allows verification of the domain rules applied to the products
    ## Examples

    iex> Product.ValidScannedProductSpecification.is_satisfied_by("VOUCHER", [%Product{code: "VOUCHER"}])
    true
  """
  def is_satisfied_by(product_code, products_allowed) do
    Enum.all?(valid_product_rules(product_code, products_allowed))
  end

  defp valid_product_rules(product_code, products_allowed) do
    [
      product_not_nil(product_code),
      product_not_empty(product_code),
      is_allowed(product_code, products_allowed)
    ]
  end

  defp product_not_nil(product), do: product != nil

  defp product_not_empty(product), do: product != ""

  defp is_allowed(product_code, products_allowed) do
    Enum.find(products_allowed, fn p -> p.code == product_code end)
  end
end
