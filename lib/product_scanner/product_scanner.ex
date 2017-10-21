defmodule ProductScanner do
  @moduledoc """
  Documentation for ProductScanner.
  """
  alias __MODULE__, as: ProductScanner
  defstruct ~w(discounters product_respository scanned_products_repository)a
  alias Discounters.DiscountsLoader
  alias Product.ValidProductSpecification
  alias ProductScanner.Infrastructure.ScannedProductsRepository
  alias Product.Infrastructure.ProductRepository
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, create_state())
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

  def handle_call({:scan, product_name}, _from, state) do
    case ValidProductSpecification.is_satisfied_by(product_name) do
      true ->
        {pid, repository} = state.scanned_products_repository
        apply(repository, :add, [pid, product_name])
        {:reply, {:ok, state}, state}
      _ ->
        message = "invalid argument, you must insert a valid product"
        {:reply, {:error, message}, state}
    end
  end

  defp create_state do
    {:ok, product_repository_pid} = ProductRepository.start_link()
    {:ok, scanned_products_repository_pid} = ScannedProductsRepository.start_link()
    %ProductScanner{
      discounters: DiscountsLoader.available_discounters(),
      product_respository: {product_repository_pid, ProductRepository},
      scanned_products_repository: {scanned_products_repository_pid, ScannedProductsRepository}
    }
  end
end
