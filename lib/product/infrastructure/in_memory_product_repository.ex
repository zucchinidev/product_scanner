defmodule Product.Infrastructure.InMemoryProductRepository do
  @moduledoc """
  Logic that handle the products list
  """

  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  def count(pid) do
    GenServer.call(pid, :count)
  end

  def add(pid, product) do
    GenServer.cast(pid, {:add, product})
  end

  def get_all(pid) do
    GenServer.call(pid, :get_all)
  end

  def handle_call(:count, _from, products) do
    {:reply, Enum.count(products), products}
  end
  def handle_call(:get_all, _from, products) do
    {:reply, products, products}
  end

  def handle_cast({:add, product}, products) do
    {:noreply, [product | products]}
  end
end
