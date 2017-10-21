defmodule Product.Infrastructure.ProductRepositoryTest do
  use ExUnit.Case
  doctest Product.Infrastructure.ProductRepository

  alias Product.Infrastructure.ProductRepository

  test "should retrieve all available products" do
    {:ok, pid} = ProductRepository.start_link()
    assert ProductRepository.get_all(pid) == get_products()
  end

  defp get_products do
    [
      %Product{code: "VOUCHER", name: "Cabify Voucher", price: 5},
      %Product{code: "TSHIRT", name: "Cabify T-Shirt", price: 20},
      %Product{code: "MUG", name: "Cafify Coffee Mug", price: 7.5}
    ]
  end
end
