defmodule Discounters.DiscountsLoader do
  @moduledoc """
  This module register all discounters available.
  """
  alias Discounters.{
    DefaultDiscounter,
    TwoForOneDiscounter,
    ThreeOrMoreDiscounter
  }

  def available_discounters do
    %{
      default: DefaultDiscounter,
      two_for_one: TwoForOneDiscounter,
      three_or_more: ThreeOrMoreDiscounter
    }
  end

end
