defmodule ClassManagementApi.UsersTest do
  use ClassManagementApi.DataCase

  alias ClassManagementApi.Users

  describe "teachers" do
    alias ClassManagementApi.Users.Teacher

    @valid_attrs %{cpf: "some cpf"}
    @update_attrs %{cpf: "some updated cpf"}
    @invalid_attrs %{cpf: nil}

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
      assert teacher.cpf == "some cpf"
    end

    test "create_teacher/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_teacher(@invalid_attrs)
    end

    test "update_teacher/2 with valid data updates the teacher" do
      teacher = teacher_fixture()
      assert {:ok, %Teacher{} = teacher} = Users.update_teacher(teacher, @update_attrs)
      assert teacher.cpf == "some updated cpf"
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
end
