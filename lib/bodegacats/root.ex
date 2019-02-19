defmodule Bodegacats.Root do
  import Mogrify

  @moduledoc """
  The Root context.
  """

  import Ecto.Query, warn: false
  alias Bodegacats.Repo

  alias Bodegacats.Root.Cat

  @doc """
  Returns the list of cat.

  ## Examples

      iex> list_cat()
      [%Cat{}, ...]

  """
  def list_cat do
    Repo.all(Cat)
  end

  @doc """
  Gets a single cat.

  Raises `Ecto.NoResultsError` if the Cat does not exist.

  ## Examples

      iex> get_cat!(123)
      %Cat{}

      iex> get_cat!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cat!(id), do: Repo.get!(Cat, id)

  @doc """
  Gets a single cat.

  Does not raise

  ## Examples

      iex> get_cat(123)
      %Cat{}

      iex> get_cat(456)
      nil

  """
  def get_cat(id), do: Repo.get(Cat, id)

  @doc """
  Creates a cat.

  ## Examples

      iex> create_cat(%{field: value})
      {:ok, %Cat{}}

      iex> create_cat(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cat(attrs \\ %{}) do
    %Cat{}
    |> Cat.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cat.

  ## Examples

      iex> update_cat(cat, %{field: new_value})
      {:ok, %Cat{}}

      iex> update_cat(cat, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cat(%Cat{} = cat, attrs) do
    cat
    |> Cat.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Cat.

  ## Examples

      iex> delete_cat(cat)
      {:ok, %Cat{}}

      iex> delete_cat(cat)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cat(%Cat{} = cat) do
    Repo.delete(cat)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cat changes.

  ## Examples

      iex> change_cat(cat)
      %Ecto.Changeset{source: %Cat{}}

  """
  def change_cat(%Cat{} = cat) do
    Cat.changeset(cat, %{})
  end

  alias Bodegacats.Root.Photo

  @doc """
  Returns the list of photo.

  ## Examples

      iex> list_photo()
      [%Photo{}, ...]

  """
  def list_photo do
    Repo.all(Photo)
  end

  @doc """
  Gets a single photo.

  Raises `Ecto.NoResultsError` if the Photo does not exist.

  ## Examples

      iex> get_photo!(123)
      %Photo{}

      iex> get_photo!(456)
      ** (Ecto.NoResultsError)

  """
  def get_photo!(id), do: Repo.get!(Photo, id)

  def resize_photo(%{path: path}, :full) do
    open(path)
    |> resize_to_limit("1000x1000")
    |> auto_orient()
    |> save()
  end

  def resize_photo(%{path: path}, :thumb) do
    open(path)
    |> resize_to_limit("300x300")
    |> auto_orient()
    |> save()
  end

  def put_to_s3({src, dest}) do
    System.get_env("BUCKET_NAME")
    |> ExAws.S3.put_object(dest, File.read!(src), acl: :public_read)
    |> ExAws.request!()
  end

  def delete_from_s3(%{id: object}) do
    System.get_env("BUCKET_NAME")
    |> ExAws.S3.delete_object(object)
    |> ExAws.request!()
  end

  def resize_and_upload({:ok, result}, upload) do
    full = resize_photo(upload, :full)
    thumb = resize_photo(upload, :thumb)

    stream =
      %{full: full, thumb: thumb}
      |> Enum.into(%{}, fn {k, v} -> {v.path, "#{result.id}-#{k}.jpg"} end)
      |> Task.async_stream(&put_to_s3/1)
      |> Stream.run()

    case stream do
      :ok -> {:ok, result}
    end
  end

  @doc """
  Creates a photo.

  ## Examples

      iex> create_photo(%{field: value})
      {:ok, %Photo{}}

      iex> create_photo(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_photo(attrs \\ %{})
  def create_photo(%{photo_upload: photo_upload} = attrs) do
    %Photo{}
    |> Photo.changeset(attrs)
    |> Repo.insert()
    |> resize_and_upload(photo_upload)
  end

  def create_photo(attrs) do
    %Photo{}
    |> Photo.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a photo.

  ## Examples

      iex> update_photo(photo, %{field: new_value})
      {:ok, %Photo{}}

      iex> update_photo(photo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_photo(%Photo{} = photo, attrs) do
    photo
    |> Photo.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Photo.

  ## Examples

      iex> delete_photo(photo)
      {:ok, %Photo{}}

      iex> delete_photo(photo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_photo(%Photo{} = photo) do
    Repo.delete(photo)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking photo changes.

  ## Examples

      iex> change_photo(photo)
      %Ecto.Changeset{source: %Photo{}}

  """
  def change_photo(%Photo{} = photo) do
    Photo.changeset(photo, %{})
  end

  alias Bodegacats.Root.Reaction

  def create_reaction(attrs \\ %{}) do
    %Reaction{}
    |> Reaction.changeset(attrs)
    |> Repo.insert()
  end

  def delete_reaction(%Reaction{} = reaction) do
    Repo.delete(reaction)
  end
end
