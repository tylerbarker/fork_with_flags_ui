defmodule ForkWithFlags.UI.TestUtils do
  @test_db 5
  @redis ForkWithFlags.Store.Persistent.Redis

  # Since the flags are saved on shared storage (ETS and
  # Redis), in order to keep the tests isolated _and_ async
  # each test must use unique flag names. Not doing so would
  # cause some tests to override other tests flag values.
  #
  # This method should _never_ be used at runtime because
  # atoms are not garbage collected.
  #
  def unique_atom do
    :crypto.strong_rand_bytes(7)
    |> Base.encode32(padding: false, case: :lower)
    |> String.to_atom()
  end

  def use_redis_test_db do
    Redix.command!(@redis, ["SELECT", @test_db])
  end

  def clear_redis_test_db do
    use_redis_test_db()

    Redix.command!(@redis, ["DEL", "fork_with_flags"])

    Redix.command!(@redis, ["KEYS", "fork_with_flags:*"])
    |> delete_keys()
  end

  defp delete_keys([]), do: 0

  defp delete_keys(keys) do
    Redix.command!(@redis, ["DEL" | keys])
  end
end
