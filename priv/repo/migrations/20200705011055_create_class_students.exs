defmodule ClassManagementApi.Repo.Migrations.CreateClassStudents do
  use Ecto.Migration

  def change do
    create table(:class_students) do
      add :student_id, references(:students, on_delete: :delete_all), primary_key: true
      add :class_id, references(:classes, on_delete: :delete_all), primary_key: true

      timestamps()
    end

    create index(:class_students, [:student_id])
    create index(:class_students, [:class_id])

    create(
      unique_index(:class_students, [:student_id, :class_id], name: :student_id_class_id_unique_index)
    )
  end
end
