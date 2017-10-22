defmodule ProductScanner.StateCreatorTest do
  use ExUnit.Case
  import ProductScanner.StateCreator

  test "should create a valid state to product scanner" do
    %ProductScanner{
      product_respository: {product_repository_pid, product_repository},
      scanned_products_repository: {scanned_products_repository_pid, scanned_products_repository}
    } = ProductScanner.StateCreator.create()

    assert is_pid(product_repository_pid) == :true
    assert is_atom(product_repository) == :true
    assert is_pid(scanned_products_repository_pid) == :true
    assert is_atom(scanned_products_repository) == :true

    assert function_exported?(scanned_products_repository, :add, 2)
    assert function_exported?(scanned_products_repository, :get_all, 1)
  end
end
