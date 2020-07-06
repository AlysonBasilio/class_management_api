defmodule ClassManagementApiWeb.ClassStudentView do
  use ClassManagementApiWeb, :view
  alias ClassManagementApiWeb.ClassStudentView

  def render("index.json", %{class_students: class_students}) do
    %{data: render_many(class_students, ClassStudentView, "class_student.json")}
  end

  def render("show.json", %{class_student: class_student}) do
    %{data: render_one(class_student, ClassStudentView, "class_student.json")}
  end

  def render("class_student.json", %{class_student: class_student}) do
    %{id: class_student.id,
      class_id: class_student.class_id,
      student_id: class_student.student_id}
  end
end
