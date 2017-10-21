defmodule ProductScanner.Discounters.RegisterDiscountersTest do
  use ExUnit.Case
  doctest ProductScanner.Discounters.RegisterDiscounters
  alias ProductScanner.Discounters.{DefaultDiscounter,TwoForOneDiscounter}

  import ProductScanner.Discounters.RegisterDiscounters, only: [
    available_discounters: 0
  ]

  test "should allow return a struct with one list of discounters modules" do
    assert available_discounters() == %{
              default: DefaultDiscounter,
              two_for_one: TwoForOneDiscounter
           }
  end
end
