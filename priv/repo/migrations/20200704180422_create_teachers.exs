defmodule ClassManagementApi.Repo.Migrations.CreateTeachers do
  use Ecto.Migration

  def change do
    create table(:teachers) do
      add :cpf, :string

      timestamps()
    end
  end
end
