defmodule ClassManagementApiWeb.ClassControllerTest do
  use ClassManagementApiWeb.ConnCase

  alias ClassManagementApi.Classes
  alias ClassManagementApi.Users
  alias ClassManagementApi.Classes.Class

  def teacher_fixture(attrs \\ %{}) do
    {:ok, teacher} =
      attrs
      |> Enum.into(%{cpf: "some cpf"})
      |> Users.create_teacher()

    teacher
  end

  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  def valid_attrs do
    teacher = teacher_fixture()
    %{name: "some name", teacher_id: teacher.id}
  end

  def fixture(:class) do
    {:ok, class} = Classes.create_class(valid_attrs())
    class
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all classes", %{conn: conn} do
      conn = get(conn, Routes.class_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create class" do
    test "renders class when data is valid", %{conn: conn} do
      conn = post(conn, Routes.class_path(conn, :create), class: valid_attrs())
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.class_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.class_path(conn, :create), class: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update class" do
    setup [:create_class]

    test "renders class when data is valid", %{conn: conn, class: %Class{id: id} = class} do
      conn = put(conn, Routes.class_path(conn, :update, class), class: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.class_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, class: class} do
      conn = put(conn, Routes.class_path(conn, :update, class), class: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete class" do
    setup [:create_class]

    test "deletes chosen class", %{conn: conn, class: class} do
      conn = delete(conn, Routes.class_path(conn, :delete, class))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.class_path(conn, :show, class))
      end
    end
  end

  defp create_class(_) do
    class = fixture(:class)
    {:ok, class: class}
  end
end
