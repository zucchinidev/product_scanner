defmodule ProductScanner.StateCreator do
  @moduledoc """
  Module to abstract the state creation of the scanner
  """
  alias Product.Infrastructure.ProductRepository
  alias ProductScanner.Infrastructure.ScannedProductsRepository

  def create do
    {:ok, scanned_products_repository_pid} = ScannedProductsRepository.start_link()
    %ProductScanner{
      product_respository: ProductRepository,
      scanned_products_repository: {scanned_products_repository_pid, ScannedProductsRepository}
    }
  end

end
