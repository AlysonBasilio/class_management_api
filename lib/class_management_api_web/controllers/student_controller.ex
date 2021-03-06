defmodule ClassManagementApiWeb.StudentController do
  use ClassManagementApiWeb, :controller

  alias ClassManagementApi.Classes
  alias ClassManagementApi.Users
  alias ClassManagementApi.Users.Student

  action_fallback ClassManagementApiWeb.FallbackController

  def index(conn, _params) do
    students = Users.list_students()
    render(conn, "index.json", students: students)
  end

  def index_class_students(conn, %{"class_id" => class_id}) do
    students = Classes.get_class_students!(class_id)
    render(conn, "index.json", students: students)
  end

  def create(conn, %{"student" => student_params}) do
    with {:ok, %Student{} = student} <- Users.create_student(student_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.student_path(conn, :show, student))
      |> render("show.json", student: student)
    end
  end

  def show(conn, %{"id" => id}) do
    student = Users.get_student!(id)
    render(conn, "show.json", student: student)
  end

  def update(conn, %{"id" => id, "student" => student_params}) do
    student = Users.get_student!(id)

    with {:ok, %Student{} = student} <- Users.update_student(student, student_params) do
      render(conn, "show.json", student: student)
    end
  end

  def delete(conn, %{"id" => id}) do
    student = Users.get_student!(id)

    with {:ok, %Student{}} <- Users.delete_student(student) do
      send_resp(conn, :no_content, "")
    end
  end
end
