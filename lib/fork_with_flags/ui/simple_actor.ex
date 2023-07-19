defmodule ForkWithFlags.UI.SimpleActor do
  @moduledoc false

  defstruct [:id]
end

# Simply return the unchanged ID.
# This is useful because all the function in the
# public API of ForkWithFlags expect actors.
#
defimpl ForkWithFlags.Actor, for: ForkWithFlags.UI.SimpleActor do
  def id(%{id: id}), do: id
end
