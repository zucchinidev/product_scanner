defmodule ProductScanner.Infrastructure.ScannedProductsRepository do
  @moduledoc """
  Module that handle the scanned products list
  Repository of products scanned in memory.
  It could be a repository with database access if it complies with the interface
  """

  use GenServer

  @doc """
  Start GenServer
  """
  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  @doc """
  Returns the total number of scanned products
  """
  def count(pid) do
    GenServer.call(pid, :count)
  end

  @doc """
  Add a product to the list of scanned products
  """
  def add(pid, product) do
    GenServer.cast(pid, {:add, product})
  end

  @doc """
  Returns list of scanned products
  """
  def get_all(pid) do
    GenServer.call(pid, :get_all)
  end

  @doc """
  Removes all scanned products
  """
  def remove_all(pid) do
    GenServer.call(pid, :remove_all)
  end

  def handle_call(:count, _from, products) do
    {:reply, Enum.count(products), products}
  end
  def handle_call(:get_all, _from, products) do
    {:reply, products, products}
  end
  def handle_call(:remove_all, _from, _products) do
    {:reply, :ok, []}
  end

  def handle_cast({:add, product}, products) do
    {:noreply, [product | products]}
  end
end
