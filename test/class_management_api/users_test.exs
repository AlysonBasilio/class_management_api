defmodule ClassManagementApi.UsersTest do
  use ClassManagementApi.DataCase

  alias ClassManagementApi.Users

  describe "teachers" do
    alias ClassManagementApi.Users.Teacher

    @valid_attrs %{cpf: CPF.generate() |> to_string()}
    @update_attrs %{cpf: CPF.generate() |> to_string()}
    @invalid_attrs %{cpf: "nil"}

    def teacher_fixture(attrs \\ %{}) do
      {:ok, teacher} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_teacher()

      teacher
    end

    test "list_teachers/0 returns all teachers" do
      teacher = teacher_fixture()
      assert Users.list_teachers() == [teacher]
    end

    test "get_teacher!/1 returns the teacher with given id" do
      teacher = teacher_fixture()
      assert Users.get_teacher!(teacher.id) == teacher
    end

    test "create_teacher/1 with valid data creates a teacher" do
      assert {:ok, %Teacher{} = teacher} = Users.create_teacher(@valid_attrs)
      {:ok, inserted_cpf} = CPF.parse(@valid_attrs[:cpf])
      assert teacher.cpf == inserted_cpf
    end

    test "create_teacher/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_teacher(@invalid_attrs)
    end

    test "update_teacher/2 with valid data updates the teacher" do
      teacher = teacher_fixture()
      assert {:ok, %Teacher{} = teacher} = Users.update_teacher(teacher, @update_attrs)
      {:ok, updated_cpf} = CPF.parse(@update_attrs[:cpf])
      assert teacher.cpf == updated_cpf
    end

    test "update_teacher/2 with invalid data returns error changeset" do
      teacher = teacher_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_teacher(teacher, @invalid_attrs)
      assert teacher == Users.get_teacher!(teacher.id)
    end

    test "delete_teacher/1 deletes the teacher" do
      teacher = teacher_fixture()
      assert {:ok, %Teacher{}} = Users.delete_teacher(teacher)
      assert_raise Ecto.NoResultsError, fn -> Users.get_teacher!(teacher.id) end
    end

    test "change_teacher/1 returns a teacher changeset" do
      teacher = teacher_fixture()
      assert %Ecto.Changeset{} = Users.change_teacher(teacher)
    end
  end

  describe "students" do
    alias ClassManagementApi.Users.Student

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def student_fixture(attrs \\ %{}) do
      {:ok, student} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_student()

      student
    end

    test "list_students/0 returns all students" do
      student = student_fixture()
      assert Users.list_students() == [student]
    end

    test "get_student!/1 returns the student with given id" do
      student = student_fixture()
      assert Users.get_student!(student.id) == student
    end

    test "create_student/1 with valid data creates a student" do
      assert {:ok, %Student{} = student} = Users.create_student(@valid_attrs)
      assert student.name == "some name"
    end

    test "create_student/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_student(@invalid_attrs)
    end

    test "update_student/2 with valid data updates the student" do
      student = student_fixture()
      assert {:ok, %Student{} = student} = Users.update_student(student, @update_attrs)
      assert student.name == "some updated name"
    end

    test "update_student/2 with invalid data returns error changeset" do
      student = student_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_student(student, @invalid_attrs)
      assert student == Users.get_student!(student.id)
    end

    test "delete_student/1 deletes the student" do
      student = student_fixture()
      assert {:ok, %Student{}} = Users.delete_student(student)
      assert_raise Ecto.NoResultsError, fn -> Users.get_student!(student.id) end
    end

    test "change_student/1 returns a student changeset" do
      student = student_fixture()
      assert %Ecto.Changeset{} = Users.change_student(student)
    end
  end
end
