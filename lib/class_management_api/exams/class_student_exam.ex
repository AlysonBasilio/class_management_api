defmodule ClassManagementApi.Exams.ClassStudentExam do
  use Ecto.Schema
  import Ecto.Changeset

  schema "class_student_exams" do
    field :status, :string, default: "Applied"
    field :exam_id, :id
    field :class_student_id, :id

    timestamps()
  end

  @doc false
  def changeset(class_student_exam, attrs) do
    class_student_exam
    |> cast(attrs, [:status, :exam_id, :class_student_id])
    |> validate_required([:status, :exam_id, :class_student_id])
  end
end
