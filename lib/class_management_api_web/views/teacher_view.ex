defmodule ClassManagementApiWeb.TeacherView do
  use ClassManagementApiWeb, :view
  alias ClassManagementApiWeb.TeacherView

  def render("index.json", %{teachers: teachers}) do
    %{data: render_many(teachers, TeacherView, "teacher.json")}
  end

  def render("show.json", %{teacher: teacher}) do
    %{data: render_one(teacher, TeacherView, "teacher.json")}
  end

  def render("teacher.json", %{teacher: teacher}) do
    %{id: teacher.id,
      cpf: to_string(teacher.cpf)}
  end
end
