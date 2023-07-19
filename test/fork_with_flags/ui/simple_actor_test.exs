defmodule ForkWithFlags.UI.SimpleActorTest do
  use ExUnit.Case, async: true

  alias ForkWithFlags.UI.SimpleActor

  test "it returns the straight ID when used as an actor" do
    id = "aubergine:98765"
    sa = %SimpleActor{id: id}
    assert ^id = ForkWithFlags.Actor.id(sa)
  end
end
