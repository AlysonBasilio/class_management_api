defmodule ClassManagementApi.ClassesTest do
  use ClassManagementApi.DataCase

  alias ClassManagementApi.Classes

  describe "classes" do
    alias ClassManagementApi.Users
    alias ClassManagementApi.Classes.Class
    alias ClassManagementApi.Classes.ClassStudent

    def teacher_fixture(attrs \\ %{}) do
      {:ok, teacher} =
        attrs
        |> Enum.into(%{cpf: CPF.generate() |> to_string()})
        |> Users.create_teacher()

      teacher
    end

    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def valid_attrs do
      teacher = teacher_fixture()
      %{name: "some name", teacher_id: teacher.id}
    end

    def class_fixture(attrs \\ %{}) do
      {:ok, class} =
        attrs
        |> Enum.into(valid_attrs())
        |> Classes.create_class()

      class
    end

    test "list_classes/0 returns all classes" do
      class = class_fixture()
      assert Classes.list_classes() == [class]
    end

    test "get_class!/1 returns the class with given id" do
      class = class_fixture()
      assert Classes.get_class!(class.id) == class
    end

    test "get_class!/1 raises an error when class with given id doesn't exist" do
      assert_raise Ecto.NoResultsError, fn -> Classes.get_class!(1) end
    end

    test "get_class_with_students!/1 returns the class with given all it students" do
      class = class_fixture()
      class_with_students = Classes.get_class_with_students!(class.id)
      assert [] == class_with_students.students
    end

    test "get_class_with_students!/1 raises an error when class with given all doesn't exist" do
      assert_raise Ecto.NoResultsError, fn -> Classes.get_class_with_students!(1) end
    end

    test "get_class_students!/1 returns the class with given all it students" do
      class = class_fixture()
      {:ok, student} = Users.create_student(%{name: "Bruce Wayne"})
      Classes.add_student_to_class(class.id, student.id)
      class_students = Classes.get_class_students!(class.id)
      assert [student] == class_students
    end

    test "get_class_students!/1 raises an error when class with given all doesn't exist" do
      assert_raise Ecto.NoResultsError, fn -> Classes.get_class_students!(1) end
    end

    test "create_class/1 with valid data creates a class" do
      assert {:ok, %Class{} = class} = Classes.create_class(valid_attrs())
      assert class.name == "some name"
    end

    test "create_class/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Classes.create_class(@invalid_attrs)
    end

    test "update_class/2 with valid data updates the class" do
      class = class_fixture()
      assert {:ok, %Class{} = class} = Classes.update_class(class, @update_attrs)
      assert class.name == "some updated name"
    end

    test "update_class/2 with invalid data returns error changeset" do
      class = class_fixture()
      assert {:error, %Ecto.Changeset{}} = Classes.update_class(class, @invalid_attrs)
      assert class == Classes.get_class!(class.id)
    end

    test "delete_class/1 deletes the class" do
      class = class_fixture()
      assert {:ok, %Class{}} = Classes.delete_class(class)
      assert_raise Ecto.NoResultsError, fn -> Classes.get_class!(class.id) end
    end

    test "change_class/1 returns a class changeset" do
      class = class_fixture()
      assert %Ecto.Changeset{} = Classes.change_class(class)
    end

    test "add_student_to_class/1 with valid data creates a class_student" do
      class = class_fixture()
      {:ok, student} = Users.create_student(%{name: "Bruce Wayne"})
      assert {:ok, %ClassStudent{} = class_student} = Classes.add_student_to_class(class.id, student.id)
      assert class_student.class_id == class.id
      assert class_student.student_id == student.id
    end

    test "add_student_to_class/1 with inexistent class returns error changeset" do
      {:ok, student} = Users.create_student(%{name: "Bruce Wayne"})
      assert {:error, %Ecto.Changeset{}} = Classes.add_student_to_class(1, student.id)
    end

    test "add_student_to_class/1 with inexistent student returns error changeset" do
      class = class_fixture()
      assert {:error, %Ecto.Changeset{}} = Classes.add_student_to_class(class.id, 1)
    end
  end
end
