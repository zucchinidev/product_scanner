defmodule Product.Infrastructure.InMemoryProductRepositoryTest do
  use ExUnit.Case
  doctest Product.Infrastructure.InMemoryProductRepository

  alias Product.Infrastructure.InMemoryProductRepository

  test "there should be no products" do
    {:ok, pid} = InMemoryProductRepository.start_link()
    assert InMemoryProductRepository.count(pid) == 0
  end

  test "should adds a product to the list" do
    {:ok, pid} = InMemoryProductRepository.start_link()
    InMemoryProductRepository.add(pid, :foo)
    assert InMemoryProductRepository.count(pid) == 1
  end

  test "should retrieve all products of the list" do
    {:ok, pid} = InMemoryProductRepository.start_link()
    InMemoryProductRepository.add(pid, :bar)
    InMemoryProductRepository.add(pid, :foo)
    assert InMemoryProductRepository.get_all(pid) == [:foo, :bar]
  end
end
