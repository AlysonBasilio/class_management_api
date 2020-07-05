defmodule ClassManagementApi.Repo.Migrations.AddUniqueIndexToCPF do
  use Ecto.Migration

  def change do
    create(
      unique_index(:teachers, [:cpf], name: :cpf_unique_index)
    )
  end
end
