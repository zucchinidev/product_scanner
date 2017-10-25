defmodule Checkout do
  @moduledoc """
  Implement a checkout process
  """

  alias __MODULE__, as: Checkout

  defstruct ~w(scanned_products available_discounters segmented_products price_rules)a

  @doc """
  Calculates the total quantity of scanned products
    ## Examples

      iex> Checkout.calculate_total_amount(
        %Checkout{
            available_discounters: DiscountsLoader.available_discounters(),
            price_rules: DiscountRules.get_rules(),
            scanned_products: ProductScanner.get_scanned_products(pid)
        }
      )
      7.5
  """
  def calculate_total_amount(%Checkout{} = state) do
    state
      |> calculate_amount()
  end

  defp calculate_amount(%Checkout{} = state) do
    state
      |> get_products_with_discounted()
      |> get_products_with_default_discounted()
      |> sum_amount()
  end

  defp get_products_with_discounted(%Checkout{scanned_products: scanned_products,
    price_rules: price_rules} = state) do
    segmented_products = Enum.reduce(Map.delete(price_rules, :default), %{}, fn ({key, rule}, acc) ->
      related_products = rule[:related_products]
      filter_products = Enum.filter(scanned_products, fn product ->
        Enum.member?(related_products, product.code)
      end)
      Map.put(acc, key, filter_products)
    end)
    %Checkout{state | segmented_products: segmented_products}
  end

  defp get_products_with_default_discounted(%Checkout{
    scanned_products: scanned_products, segmented_products: segmented_products} = state) do
    default_products = Enum.filter(scanned_products, fn product ->
      condition = Enum.reduce(segmented_products, true, fn ({_key, related_products}, acc) ->
        acc && !Enum.member?(related_products, product)
      end)
      condition
    end)
    segmented_products = Map.put(segmented_products, :default, default_products)
    %Checkout{state | segmented_products: segmented_products}
  end

  defp sum_amount(%Checkout{available_discounters: discounters,
    segmented_products: segmented_products, price_rules: price_rules}) do
    Enum.reduce(segmented_products, 0, fn ({discounter, products}, acc) ->
      price_rule = price_rules[discounter]
      acc + apply(discounters[discounter], :perform_discount, [products, price_rule])
    end)
  end
end
