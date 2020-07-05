defmodule ClassManagementApiWeb.ClassController do
  use ClassManagementApiWeb, :controller

  alias ClassManagementApi.Classes
  alias ClassManagementApi.Classes.Class
  alias ClassManagementApi.Users

  action_fallback ClassManagementApiWeb.FallbackController

  def index(conn, _params) do
    classes = Classes.list_classes()
    render(conn, "index.json", classes: classes)
  end

  def create(conn, %{"class" => class_params}) do
    with {:ok, %Class{} = class} <- Classes.create_class(class_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.class_path(conn, :show, class))
      |> render("show.json", class: class)
    end
  end

  def show(conn, %{"id" => id}) do
    class = Classes.get_class!(id)
    render(conn, "show.json", class: class)
  end

  def update(conn, %{"id" => id, "class" => class_params}) do
    class = Classes.get_class!(id)

    with {:ok, %Class{} = class} <- Classes.update_class(class, class_params) do
      render(conn, "show.json", class: class)
    end
  end

  def delete(conn, %{"id" => id}) do
    class = Classes.get_class!(id)

    with {:ok, %Class{}} <- Classes.delete_class(class) do
      send_resp(conn, :no_content, "")
    end
  end

  def enroll_student(conn, %{"class_id" => class_id, "student_id" => student_id}) do
    class = Classes.get_class_with_students!(class_id)
    student = Users.get_student!(student_id)

    with {:ok, %Class{} = class} <- Classes.add_student_to_class(class, student) do
      render(conn, "show.json", class: class)
    end
  end
end
