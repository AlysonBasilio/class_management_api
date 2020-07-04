defmodule ClassManagementApi.Users.Teacher do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teachers" do
    field :cpf, :string

    timestamps()
  end

  @doc false
  def changeset(teacher, attrs) do
    teacher
    |> cast(attrs, [:cpf])
    |> validate_required([:cpf])
  end
end
