defmodule Product.Infrastructure.ProductRepository do
  @moduledoc """
  Module that handle the available products list
  """

  import Product

  def get_all() do
    {:ok, products_data} = "./products.json"
                           |> Path.expand(__DIR__)
                           |> File.read()
    Poison.decode!(products_data, as: [%Product{}])
  end
end
