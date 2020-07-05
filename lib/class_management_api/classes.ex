defmodule ClassManagementApi.Classes do
  @moduledoc """
  The Classes context.
  """

  import Ecto.Query, warn: false
  alias ClassManagementApi.Repo

  alias ClassManagementApi.Classes.Class

  @doc """
  Returns the list of classes.

  ## Examples

      iex> list_classes()
      [%Class{}, ...]

  """
  def list_classes do
    Repo.all(Class)
  end

  @doc """
  Gets a single class.

  Raises `Ecto.NoResultsError` if the Class does not exist.

  ## Examples

      iex> get_class!(123)
      %Class{}

      iex> get_class!(456)
      ** (Ecto.NoResultsError)

  """
  def get_class!(id), do: Repo.get!(Class, id)

  @doc """
  Gets a single class with all students.

  Raises `Ecto.NoResultsError` if the Class does not exist.

  ## Examples

      iex> get_class_with_students!(123)
      %Class{}

      iex> get_class_with_students!(456)
      ** (Ecto.NoResultsError)

  """
  def get_class_with_students!(id) do
    get_class!(id)
      |> Repo.preload(:students)
  end

  @doc """
  Gets all students from a class.

  Raises `Ecto.NoResultsError` if the Class does not exist.

  ## Examples

      iex> get_class_with_students!(123)
      [%Student{}, ...]

      iex> get_class_with_students!(456)
      ** (Ecto.NoResultsError)

  """
  def get_class_students!(id) do
    class = get_class_with_students!(id)
    class.students
  end

  @doc """
  Creates a class.

  ## Examples

      iex> create_class(%{field: value})
      {:ok, %Class{}}

      iex> create_class(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_class(attrs \\ %{}) do
    %Class{}
    |> Class.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a class.

  ## Examples

      iex> update_class(class, %{field: new_value})
      {:ok, %Class{}}

      iex> update_class(class, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_class(%Class{} = class, attrs) do
    class
    |> Class.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a class.

  ## Examples

      iex> delete_class(class)
      {:ok, %Class{}}

      iex> delete_class(class)
      {:error, %Ecto.Changeset{}}

  """
  def delete_class(%Class{} = class) do
    Repo.delete(class)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking class changes.

  ## Examples

      iex> change_class(class)
      %Ecto.Changeset{source: %Class{}}

  """
  def change_class(%Class{} = class) do
    Class.changeset(class, %{})
  end

  def add_student_to_class(class, student) do
    new_students = Enum.concat(class.students, [student])
    class
    |> Class.changeset_update_students(new_students)
    |> Repo.update()
  end
end
