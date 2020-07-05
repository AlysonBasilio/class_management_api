defmodule ClassManagementApi.Repo.Migrations.CreateClassStudentExams do
  use Ecto.Migration

  def change do
    create table(:class_student_exams) do
      add :status, :string, default: "Applied"
      add :exam_id, references(:exams, on_delete: :delete_all)
      add :class_student_id, references(:class_students, on_delete: :delete_all)

      timestamps()
    end

    create index(:class_student_exams, [:exam_id])
    create index(:class_student_exams, [:class_student_id])

    create(
      unique_index(:class_student_exams, [:exam_id, :class_student_id], name: :exam_id_class_student_id_unique_index)
    )
  end
end
