defmodule Checkout do
  @moduledoc false

  alias __MODULE__, as: Checkout

  defstruct ~w(scanned_products product_respository available_discounters filtered_products)a

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

  defp get_products_with_discounted(%Checkout{scanned_products: scanned_products} = state) do
    discounted_products = Enum.reduce(get_rules(), %{}, fn ({key, rule}, acc) ->
      related_products = rule[:related_products]
      filter_products = Enum.filter(scanned_products, fn product ->
        Enum.member?(related_products, product.code)
      end)
      Map.put(acc, key, filter_products)
    end)
    %Checkout{state | filtered_products: discounted_products}
  end

  defp get_products_with_default_discounted(%Checkout{
    scanned_products: scanned_products, filtered_products: filtered_products} = state) do
    default_products = Enum.filter(scanned_products, fn product ->
      condition = Enum.reduce(filtered_products, true, fn ({_key, related_products}, acc) ->
        acc && !Enum.member?(related_products, product)
      end)
      condition
    end)
    discounted_products = Map.put(filtered_products, :default, default_products)
    %Checkout{state | filtered_products: discounted_products}
  end

  defp sum_amount(%Checkout{
    available_discounters: discounters, filtered_products: filtered_products}) do
    Enum.reduce(filtered_products, 0, fn ({discounter, products}, acc) ->
      acc + apply(discounters[discounter], :perform_discount, [products])
    end)
  end

  defp get_rules do
    %{
      two_for_one: %{
        related_products: ["VOUCHER"]
      },
      three_or_more: %{
        related_products: ["TSHIRT"]
      }
    }
  end
end
