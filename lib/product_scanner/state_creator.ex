defmodule ProductScanner.StateCreator do
  @moduledoc """
  Module to abstract the state creation of the scanner
  """
  alias Product.Infrastructure.ProductRepository
  alias ProductScanner.Infrastructure.ScannedProductsRepository

  def create do
    {:ok, product_repository_pid} = ProductRepository.start_link()
    {:ok, scanned_products_repository_pid} = ScannedProductsRepository.start_link()
    %ProductScanner{
      product_respository: {product_repository_pid, ProductRepository},
      scanned_products_repository: {scanned_products_repository_pid, ScannedProductsRepository}
    }
  end

end
