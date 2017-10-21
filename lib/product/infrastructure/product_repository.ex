defmodule Product.Infrastructure.ProductRepository do
  @moduledoc """
  Module that handle the available products list
  """
  use GenServer

  import Product

  def start_link do
    {:ok, products_data} = "./products.json"
      |> Path.expand(__DIR__)
      |> File.read()
    products = Poison.decode!(products_data, as: [%Product{}])
    GenServer.start_link(__MODULE__, products)
  end

  def get_all(pid) do
    GenServer.call(pid, :get_all)
  end

  def handle_call(:get_all, _from, products) do
    {:reply, products, products}
  end
end
