defmodule Product.Infrastructure.ProductRepository do
  @moduledoc """
  Module that handle the available products list
  In this case it is a file. It could be any resource that complies with the contract
  """

  import Product

  @doc """
  Gets all available products in the system.
  """
  def get_all() do
    {:ok, products_data} = "./products.json"
                           |> Path.expand(__DIR__)
                           |> File.read()
    Poison.decode!(products_data, as: [%Product{}])
  end
end
