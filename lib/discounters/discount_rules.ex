defmodule Discounters.DiscountRules do
  @moduledoc """
  This module obtain the discount rules
  """
#  TODO Get rules from a resource (database, etc)
  @doc """
  Return the discount rules
    ## Examples

      iex> Discounters.DiscountRules.get_rules()
      %{
        two_for_one: %{
          related_products: ["VOUCHER"],
          base_price: 5,
          discounted_price: 2.5
        },
        three_or_more: %{
          related_products: ["TSHIRT"],
          base_price: 20,
          discounted_price: 19
        }
      }
  """
  def get_rules do
    %{
      two_for_one: %{
        related_products: ["VOUCHER"],
        base_price: 5,
        discounted_price: 2.5
      },
      three_or_more: %{
        related_products: ["TSHIRT"],
        base_price: 20,
        discounted_price: 19
      }
    }
  end
end
