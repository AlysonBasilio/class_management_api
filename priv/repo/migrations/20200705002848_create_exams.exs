defmodule ClassManagementApi.Repo.Migrations.CreateExams do
  use Ecto.Migration

  def change do
    create table(:exams) do
      add :subject, :string, null: false
      add :type, :string, null: false
      add :teacher_id, references(:teachers, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:exams, [:teacher_id])
  end
end
