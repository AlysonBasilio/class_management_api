defmodule ClassManagementApiWeb.ExamController do
  use ClassManagementApiWeb, :controller

  alias ClassManagementApi.Exams
  alias ClassManagementApi.Exams.Exam

  action_fallback ClassManagementApiWeb.FallbackController

  def index(conn, _params) do
    exams = Exams.list_exams()
    render(conn, "index.json", exams: exams)
  end

  def create(conn, %{"exam" => exam_params}) do
    with {:ok, %Exam{} = exam} <- Exams.create_exam(exam_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.exam_path(conn, :show, exam))
      |> render("show.json", exam: exam)
    end
  end

  def show(conn, %{"id" => id}) do
    exam = Exams.get_exam!(id)
    render(conn, "show.json", exam: exam)
  end

  def update(conn, %{"id" => id, "exam" => exam_params}) do
    exam = Exams.get_exam!(id)

    with {:ok, %Exam{} = exam} <- Exams.update_exam(exam, exam_params) do
      render(conn, "show.json", exam: exam)
    end
  end

  def delete(conn, %{"id" => id}) do
    exam = Exams.get_exam!(id)

    with {:ok, %Exam{}} <- Exams.delete_exam(exam) do
      send_resp(conn, :no_content, "")
    end
  end
end
