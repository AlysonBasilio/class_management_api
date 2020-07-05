defmodule ClassManagementApi.Users.Teacher do
  use Ecto.Schema

  import Ecto.Changeset
  import CPF.Ecto.Type

  alias ClassManagementApi.Classes.Class

  schema "teachers" do
    field :cpf, cpf_type(:string)

    timestamps()

    has_many :classes, Class
  end

  @doc false
  def changeset(teacher, attrs) do
    teacher
    |> cast(attrs, [:cpf])
    |> validate_required([:cpf])
  end
end
