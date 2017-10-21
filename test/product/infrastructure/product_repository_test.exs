defmodule Product.Infrastructure.ProductRepositoryTest do
  use ExUnit.Case
  doctest Product.Infrastructure.ProductRepository

  alias Product.Infrastructure.ProductRepository

  test "there should be no products" do
    {:ok, pid} = ProductRepository.start_link()
    assert ProductRepository.count(pid) == 0
  end

  test "should adds a product to the list" do
    {:ok, pid} = ProductRepository.start_link()
    ProductRepository.add(pid, :foo)
    assert ProductRepository.count(pid) == 1
  end

  test "should retrieve all products of the list" do
    {:ok, pid} = ProductRepository.start_link()
    ProductRepository.add(pid, :bar)
    ProductRepository.add(pid, :foo)
    assert ProductRepository.get_all(pid) == [:foo, :bar]
  end
end
