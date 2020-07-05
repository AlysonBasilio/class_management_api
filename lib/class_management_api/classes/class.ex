defmodule ClassManagementApi.Classes.Class do
  use Ecto.Schema
  import Ecto.Changeset
  alias ClassManagementApi.Users.Teacher
  alias ClassManagementApi.Users.Student
  alias ClassManagementApi.Classes.ClassStudent

  @required_fields [:name, :teacher_id]

  schema "classes" do
    field :name, :string

    timestamps()

    belongs_to :teacher, Teacher
    many_to_many :students, Student, join_through: ClassStudent, on_replace: :delete
  end

  @doc false
  def changeset(class, attrs) do
    class
    |> cast(attrs, @required_fields)
    |> cast_assoc(:students, with: &Student.changeset/2)
    |> validate_required(@required_fields)
  end

  @doc false
  def changeset_update_students(class, students) do
    class
    |> cast(%{}, @required_fields)
    |> cast_assoc(:students, with: &Student.changeset/2)
    |> put_assoc(:students, students)
  end
end
