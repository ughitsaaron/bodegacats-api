ExUnit.start(exclude: [:skip])
Ecto.Adapters.SQL.Sandbox.mode(Bodegacats.Repo, :manual)
Absinthe.Test.prime(Bodegacats.Schema)
