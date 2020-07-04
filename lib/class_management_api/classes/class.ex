defmodule ClassManagementApi.Classes.Class do
  use Ecto.Schema
  import Ecto.Changeset
  alias ClassManagementApi.Users.Teacher

  schema "classes" do
    field :name, :string

    timestamps()

    belongs_to :teacher, Teacher
  end

  @doc false
  def changeset(class, attrs) do
    class
    |> cast(attrs, [:name, :teacher_id])
    |> validate_required([:name, :teacher_id])
  end
end
