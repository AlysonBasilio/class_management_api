defmodule ClassManagementApi.Repo.Migrations.RemoveClassStudentMultiplePKsRelation do
  use Ecto.Migration

  def change do
    drop constraint("class_students", "class_students_pkey")

    alter table(:class_students) do
      modify(:id, :integer, primary_key: true)
    end
  end
end
