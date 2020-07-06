defmodule ClassManagementApiWeb.ClassStudentController do
  use ClassManagementApiWeb, :controller

  alias ClassManagementApi.Classes

  action_fallback ClassManagementApiWeb.FallbackController

  def enroll_student(conn, %{"class_id" => class_id, "student_id" => student_id}) do
    with {:ok, class_student} <- Classes.add_student_to_class(class_id, student_id) do
      render(conn, "show.json", class_student: class_student)
    end
  end
end
