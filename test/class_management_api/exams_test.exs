defmodule ClassManagementApi.ExamsTest do
  use ClassManagementApi.DataCase

  alias ClassManagementApi.Exams

  describe "exams" do
    alias ClassManagementApi.Users
    alias ClassManagementApi.Exams.Exam

    def teacher_fixture(attrs \\ %{}) do
      {:ok, teacher} =
        attrs
        |> Enum.into(%{cpf: "some cpf"})
        |> Users.create_teacher()

      teacher
    end

    @update_attrs %{subject: "some updated subject", type: "some updated type"}
    @invalid_attrs %{subject: nil, type: nil}

    def valid_attrs do
      teacher = teacher_fixture()
      %{subject: "some subject", type: "some type", teacher_id: teacher.id}
    end

    def exam_fixture(attrs \\ %{}) do
      {:ok, exam} =
        attrs
        |> Enum.into(valid_attrs())
        |> Exams.create_exam()

      exam
    end

    test "list_exams/0 returns all exams" do
      exam = exam_fixture()
      assert Exams.list_exams() == [exam]
    end

    test "get_exam!/1 returns the exam with given id" do
      exam = exam_fixture()
      assert Exams.get_exam!(exam.id) == exam
    end

    test "create_exam/1 with valid data creates a exam" do
      assert {:ok, %Exam{} = exam} = Exams.create_exam(valid_attrs())
      assert exam.subject == "some subject"
      assert exam.type == "some type"
    end

    test "create_exam/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Exams.create_exam(@invalid_attrs)
    end

    test "update_exam/2 with valid data updates the exam" do
      exam = exam_fixture()
      assert {:ok, %Exam{} = exam} = Exams.update_exam(exam, @update_attrs)
      assert exam.subject == "some updated subject"
      assert exam.type == "some updated type"
    end

    test "update_exam/2 with invalid data returns error changeset" do
      exam = exam_fixture()
      assert {:error, %Ecto.Changeset{}} = Exams.update_exam(exam, @invalid_attrs)
      assert exam == Exams.get_exam!(exam.id)
    end

    test "delete_exam/1 deletes the exam" do
      exam = exam_fixture()
      assert {:ok, %Exam{}} = Exams.delete_exam(exam)
      assert_raise Ecto.NoResultsError, fn -> Exams.get_exam!(exam.id) end
    end

    test "change_exam/1 returns a exam changeset" do
      exam = exam_fixture()
      assert %Ecto.Changeset{} = Exams.change_exam(exam)
    end
  end
end
