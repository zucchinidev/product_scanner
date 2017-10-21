defmodule Discounters.DiscountsLoader do
  @moduledoc """
  This module register all discounters available.
  """
  alias Discounters.{DefaultDiscounter,TwoForOneDiscounter}

  def available_discounters do
    %{
      default: DefaultDiscounter,
      two_for_one: TwoForOneDiscounter
    }
  end

end
