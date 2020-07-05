defmodule ClassManagementApiWeb.ClassStudentExamController do
  use ClassManagementApiWeb, :controller

  alias ClassManagementApi.Exams
  alias ClassManagementApi.Exams.ClassStudentExam

  action_fallback ClassManagementApiWeb.FallbackController

  def apply_exam_to_class(conn, %{"class_id" => class_id, "exam_id" => exam_id}) do
    with {_qty, class_student_exams} <- Exams.apply_exam_to_class(class_id, exam_id) do
      conn
      |> put_status(:created)
      |> render("index.json", class_student_exams: class_student_exams)
    end
  end

  def update(conn, %{"id" => id, "class_student_exam" => class_student_exam_params}) do
    class_student_exam = Exams.get_class_student_exam!(id)

    with {:ok, %ClassStudentExam{} = class_student_exam} <- Exams.update_class_student_exam(class_student_exam, class_student_exam_params) do
      render(conn, "show.json", class_student_exam: class_student_exam)
    end
  end
end
