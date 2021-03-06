defmodule ProductScanner do
  @moduledoc """
  Documentation for ProductScanner.
  """
  alias __MODULE__, as: ProductScanner
  defstruct ~w(product_respository scanned_products_repository)a
  alias Product.ValidScannedProductSpecification
  use GenServer

  def start_link(%ProductScanner{} = state) do
    GenServer.start_link(__MODULE__, state)
  end

  @doc """
  Scan products in any order.

  ## Examples

      iex> ProductScanner.scan(pid, "VOUCHER")
      {:ok, %{}}

  """
  def scan(pid, product_name) do
    GenServer.call(pid, {:scan, product_name})
  end

  @doc """
  Retrieve all scanned products.

  ## Examples

      iex> ProductScanner.get_scanned_products(pid)
      ["VOUCHER", "TSHIRT"]

  """
  def get_scanned_products(pid) do
    GenServer.call(pid, :get_scanned_products)
  end

  @doc """
  Removes all scanned products
  """
  def remove_scanned_products(pid) do
    GenServer.call(pid, :remove_scanned_products)
  end

  def handle_call({:scan, product_code}, _from, state) do
    products = apply(state.product_respository, :get_all, [])
    case ValidScannedProductSpecification.is_satisfied_by(product_code, products) do
      true ->
        scanned_product = Enum.find(products, fn p -> p.code == product_code end)
        {pid, repository} = state.scanned_products_repository
        apply(repository, :add, [pid, scanned_product])
        {:reply, {:ok, state}, state}
      _ ->
        message = "invalid argument, you must insert a valid product"
        {:reply, {:error, message}, state}
    end
  end

  def handle_call(:get_scanned_products, _from, state) do
    {pid, repository} = state.scanned_products_repository
    products = apply(repository, :get_all, [pid])
    {:reply, products, state}
  end

  def handle_call(:remove_scanned_products, _from, state) do
    {pid, repository} = state.scanned_products_repository
    products = apply(repository, :remove_all, [pid])
    {:reply, products, state}
  end
end
