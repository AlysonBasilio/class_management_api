defmodule ClassManagementApi.Users.Teacher do
  use Ecto.Schema
  import Ecto.Changeset
  alias ClassManagementApi.Classes.Class

  schema "teachers" do
    field :cpf, :string

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
