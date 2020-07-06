defmodule ClassManagementApi.Classes.ClassStudent do
  use Ecto.Schema
  import Ecto.Changeset

  schema "class_students" do
    field :student_id, :id
    field :class_id, :id

    timestamps()
  end

  @doc false
  def changeset(class_student, attrs) do
    class_student
    |> cast(attrs, [:student_id, :class_id])
    |> foreign_key_constraint(:student_id)
    |> foreign_key_constraint(:class_id)
    |> validate_required([:student_id, :class_id])
  end
end
