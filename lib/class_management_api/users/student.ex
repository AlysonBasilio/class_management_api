defmodule ClassManagementApi.Users.Student do
  use Ecto.Schema
  import Ecto.Changeset
  alias ClassManagementApi.Classes.Class
  alias ClassManagementApi.Classes.ClassStudent

  @required_fields [:name]

  schema "students" do
    field :name, :string

    timestamps()
    many_to_many :classes, Class, join_through: ClassStudent, on_replace: :delete
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, @required_fields)
    |> cast_assoc(:classes, with: &Class.changeset/2)
    |> validate_required(@required_fields)
  end

  @doc false
  def changeset_update_classes(student, classes) do
    student
    |> cast(%{}, @required_fields)
    |> cast_assoc(:classes, with: &Class.changeset/2)
    |> put_assoc(:classes, classes)
  end
end
