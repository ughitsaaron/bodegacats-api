# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Bodegacats.Repo.insert!(%Bodegacats.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Bodegacats.Repo.insert!(%Bodegacats.Root.Cat{
  lat: 40.6904125,
  lng: -73.9933927,
});

Bodegacats.Repo.insert!(%Bodegacats.Root.Cat{
  lat: 40.717517,
  lng: -73.9838227,
});


Bodegacats.Repo.insert!(%Bodegacats.Root.Cat{
  lat: 40.712379,
  lng: -73.9501757,
});
