defmodule ClassManagementApi.Repo.Migrations.CreateClasses do
  use Ecto.Migration

  def change do
    create table(:classes) do
      add :name, :string, null: false
      add :teacher_id, references(:teachers, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:classes, [:teacher_id])
  end
end
