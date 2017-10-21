defmodule Discounters.LoaderTest do
  use ExUnit.Case
  doctest Discounters.DiscountsLoader
  alias Discounters.{DefaultDiscounter,TwoForOneDiscounter}

  import Discounters.DiscountsLoader, only: [
    available_discounters: 0
  ]

  test "should allow return a struct with one list of discounters modules" do
    assert available_discounters() == %{
              default: DefaultDiscounter,
              two_for_one: TwoForOneDiscounter
           }
  end
end
