defmodule ClassManagementApi.Repo.Migrations.RemoveTeacherExamRelation do
  use Ecto.Migration

  def change do
    drop index(:exams, [:teacher_id])

    alter table(:exams) do
      remove :teacher_id, references(:teachers, on_delete: :delete_all), null: false
    end
  end
end
