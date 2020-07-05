defmodule ClassManagementApi.Exams.Exam do
  use Ecto.Schema
  import Ecto.Changeset

  schema "exams" do
    field :subject, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(exam, attrs) do
    exam
    |> cast(attrs, [:subject, :type])
    |> validate_required([:subject, :type])
  end
end
