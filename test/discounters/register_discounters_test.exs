defmodule Discounters.RegisterDiscountersTest do
  use ExUnit.Case
  doctest Discounters.RegisterDiscounters
  alias Discounters.{DefaultDiscounter,TwoForOneDiscounter}

  import Discounters.RegisterDiscounters, only: [
    available_discounters: 0
  ]

  test "should allow return a struct with one list of discounters modules" do
    assert available_discounters() == %{
              default: DefaultDiscounter,
              two_for_one: TwoForOneDiscounter
           }
  end
end
