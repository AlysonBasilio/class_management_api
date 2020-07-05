defmodule ClassManagementApi.Exams.Exam do
  use Ecto.Schema
  import Ecto.Changeset
  alias ClassManagementApi.Users.Teacher

  schema "exams" do
    field :subject, :string
    field :type, :string

    timestamps()

    belongs_to :teacher, Teacher
  end

  @doc false
  def changeset(exam, attrs) do
    exam
    |> cast(attrs, [:subject, :type, :teacher_id])
    |> validate_required([:subject, :type, :teacher_id])
  end
end
