defmodule ClassManagementApiWeb.ClassStudentExamController do
  use ClassManagementApiWeb, :controller

  alias ClassManagementApi.Exams

  action_fallback ClassManagementApiWeb.FallbackController

  def apply_exam_to_class(conn, %{"class_id" => class_id, "exam_id" => exam_id}) do
    with {_qty, class_student_exams} <- Exams.apply_exam_to_class(class_id, exam_id) do
      conn
      |> put_status(:created)
      |> render("index.json", class_student_exams: class_student_exams)
    end
  end
end
