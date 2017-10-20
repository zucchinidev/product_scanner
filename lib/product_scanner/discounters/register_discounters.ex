defmodule ProductScanner.Discounters.RegisterDiscounters do
  @moduledoc """
  This module register all discounters enabled.
  """
  alias ProductScanner.Discounters.{DefaultDiscounter,TwoForOneDiscounter}

  def available_discounters do
    [DefaultDiscounter, TwoForOneDiscounter]
  end

end
