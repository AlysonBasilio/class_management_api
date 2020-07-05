defmodule ClassManagementApiWeb.ExamControllerTest do
  use ClassManagementApiWeb.ConnCase

  alias ClassManagementApi.Exams
  alias ClassManagementApi.Exams.Exam

  @valid_attrs %{
    subject: "some subject",
    type: "some type"
  }
  @update_attrs %{
    subject: "some updated subject",
    type: "some updated type"
  }
  @invalid_attrs %{subject: nil, type: nil}

  def fixture(:exam) do
    {:ok, exam} = Exams.create_exam(@valid_attrs)
    exam
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all exams", %{conn: conn} do
      conn = get(conn, Routes.exam_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create exam" do
    test "renders exam when data is valid", %{conn: conn} do
      conn = post(conn, Routes.exam_path(conn, :create), exam: @valid_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.exam_path(conn, :show, id))

      assert %{
               "id" => id,
               "subject" => "some subject",
               "type" => "some type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.exam_path(conn, :create), exam: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update exam" do
    setup [:create_exam]

    test "renders exam when data is valid", %{conn: conn, exam: %Exam{id: id} = exam} do
      conn = put(conn, Routes.exam_path(conn, :update, exam), exam: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.exam_path(conn, :show, id))

      assert %{
               "id" => id,
               "subject" => "some updated subject",
               "type" => "some updated type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, exam: exam} do
      conn = put(conn, Routes.exam_path(conn, :update, exam), exam: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete exam" do
    setup [:create_exam]

    test "deletes chosen exam", %{conn: conn, exam: exam} do
      conn = delete(conn, Routes.exam_path(conn, :delete, exam))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.exam_path(conn, :show, exam))
      end
    end
  end

  defp create_exam(_) do
    exam = fixture(:exam)
    {:ok, exam: exam}
  end
end
