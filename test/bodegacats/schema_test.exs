defmodule Bodegacats.SchemaTest do
  use BodegacatsWeb.ConnCase, async: true
  alias Bodegacats.Repo
  alias Bodegacats.Root.Cat
  alias Bodegacats.Root.Photo

  defp create_cat() do
    Repo.insert!(%Cat{lat: 120.5, lng: 120.5})
  end

  defp create_photo(cat_id) do
    Repo.insert!(%Photo{cat_id: cat_id})
  end

  defp query_helper(conn, query, variables \\ nil) do
    res = conn
      |> post("/graphql", %{query: query, variables: variables})
      |> json_response(200)

    res["errors"] || res["data"]
  end

  @tag :list_cats
  describe "list_cats" do
    test "returns a list of cats", context do
      cat = create_cat()

      allCats = """
      {
        cats {
          id,
          lat,
          lng
        }
      }
      """

      assert context.conn
        |> query_helper(allCats)
        |> Map.fetch!("cats")
        |> Enum.any?(fn item ->
          String.to_integer(item["id"]) == cat.id
        end)
    end
  end

  @tag :get_cat
  describe "get cat" do
    test "returns a cat by id", context do
      cat = create_cat()
      photo = create_photo(cat.id)

      catById = """
      query($id: Int) {
        cat(id: $id) {
          id,
          lat,
          lng,
          photos {
            id
          }
        }
      }
      """

      assert context.conn
        |> query_helper(catById, %{id: cat.id})
        |> Map.fetch!("cat")
        |> Map.equal?(%{
          "id" => "#{cat.id}",
          "lat" => cat.lat,
          "lng" => cat.lng,
          "photos" => [%{
            "id" => "#{photo.id}"
          }]
        })
    end
  end

  @tag :create_cat
  describe "create cat" do
    test "it creates a new cat record", context do
      createCat = """
      mutation($lat: Float!, $lng: Float!) {
        createCat(lat: $lat, lng: $lng) {
          id,
          lat,
          lng,
        }
      }
      """

      result = context.conn
        |> query_helper(createCat, %{
          lat: 66.6,
          lng: 4.20,
        })
        |> Map.fetch!("createCat")

      assert Map.equal?(result, %{
          "id" => result["id"],
          "lat" => 66.6,
          "lng" => 4.20,
        })
    end
  end
end
