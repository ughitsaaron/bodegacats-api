defmodule Bodegacats.Schema.Resolvers do
  import Ecto.Query

  alias Bodegacats.Repo
  alias Bodegacats.Root.Cat
  alias Bodegacats.Root.Photo
  alias Bodegacats.Root.Reaction

  def list_cats(_parent, _args, _resolution) do
    {:ok, Repo.all(Cat)}
  end

  def get_cat(%Photo{cat_id: id}, _args, _resolution) do
    case Repo.get(Cat, id) do
      nil ->
        {:error, "Cat #{id} not found"}

      cat ->
        {:ok, cat}
    end
  end

  def get_cat(%Reaction{cat_id: id}, _args, _resolution) do
    case Repo.get(Cat, id) do
      nil ->
        {:error, "Cat #{id} not found"}

      cat ->
        {:ok, cat}
    end
  end

  def get_cat(_parent, %{id: id}, _resolution) do
    case Repo.get(Cat, id) do
      nil ->
        {:error, "Cat #{id} not found"}

      cat ->
        {:ok, cat}
    end
  end

  def create_cat(_parent, args, _context) do
    Bodegacats.Root.create_cat(args)
  end

  def delete_cat(_parent, %{id: id, key: key}, _context) do
    query = from c in Cat, where: c.id == ^id
    admin_key = Application.get_env(:bodegacats, :admin_key)

    case Repo.one(query) do
      nil ->
        {:error, "Cat #{id} not found"}
      cat when key == admin_key ->
        Bodegacats.Root.delete_cat(cat)
    end
  end

  def get_reactions(%Cat{id: id}, _args, _resolution) do
    query = from p in Reaction, where: p.cat_id == ^id
    {:ok, Repo.all(query)}
  end

  def add_reaction(_parent, args, _context) do
    Bodegacats.Root.create_reaction(args)
  end

  def remove_reaction(_parent, %{cat_id: cat_id, user_id: user_id, type: type}, _context) do
    where = [cat_id: cat_id, user_id: user_id, type: type]
    query = from p in Reaction, where: ^where

    case Repo.one(query) do
      nil ->
        {:error, "Reaction not found"}

      reaction ->
        Bodegacats.Root.delete_reaction(reaction)
    end
  end

  def get_photos(%Cat{id: id}, _args, _resolution) do
    query = from p in Photo, where: p.cat_id == ^id
    {:ok, Repo.all(query)}
  end

  def get_photos(_parent, _args, _resolution) do
    {:ok, Repo.all(Photo)}
  end

  def get_photo(_parent, %{id: id}, _resolution) do
    case Repo.get(Photo, id) do
      nil ->
        {:error, "Photo #{id} not found"}

      photo ->
        {:ok, photo}
    end
  end

  def create_photo(_parent, args, _context) do
    Bodegacats.Root.create_photo(args)
  end
end
