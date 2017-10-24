defmodule ProductScanner.Infrastructure.ScannedProductsRepositoryTest do
  use ExUnit.Case
  doctest ProductScanner.Infrastructure.ScannedProductsRepository

  import ProductScanner.Infrastructure.ScannedProductsRepository, only: [
    start_link: 0,
    count: 1,
    add: 2,
    get_all: 1,
    remove_all: 1
  ]

  test "there should be no products" do
    {:ok, pid} = start_link()
    assert count(pid) == 0
  end

  test "should adds a product to the list" do
    {:ok, pid} = start_link()
    add(pid, :foo)
    assert count(pid) == 1
  end

  test "should retrieve all scanned products" do
    {:ok, pid} = start_link()
    add(pid, :bar)
    add(pid, :foo)
    assert get_all(pid) == [:foo, :bar]
  end

  test "should remove all scanned products" do
    {:ok, pid} = start_link()
    add(pid, :bar)
    add(pid, :foo)
    assert remove_all(pid) == :ok
    assert length(get_all(pid)) == 0
  end
end
