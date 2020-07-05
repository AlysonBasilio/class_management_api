defmodule ClassManagementApi.Exams do
  @moduledoc """
  The Exams context.
  """

  import Ecto.Query, warn: false
  alias ClassManagementApi.Repo

  alias ClassManagementApi.Exams.Exam
  alias ClassManagementApi.Exams.ClassStudentExam
  alias ClassManagementApi.Classes.ClassStudent

  @doc """
  Returns the list of exams.

  ## Examples

      iex> list_exams()
      [%Exam{}, ...]

  """
  def list_exams do
    Repo.all(Exam)
  end

  def get_class_student_exam!(id), do: Repo.get!(ClassStudentExam, id)

  @doc """
  Gets a single exam.

  Raises `Ecto.NoResultsError` if the Exam does not exist.

  ## Examples

      iex> get_exam!(123)
      %Exam{}

      iex> get_exam!(456)
      ** (Ecto.NoResultsError)

  """
  def get_exam!(id), do: Repo.get!(Exam, id)

  @doc """
  Creates a exam.

  ## Examples

      iex> create_exam(%{field: value})
      {:ok, %Exam{}}

      iex> create_exam(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_exam(attrs \\ %{}) do
    %Exam{}
    |> Exam.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a exam.

  ## Examples

      iex> update_exam(exam, %{field: new_value})
      {:ok, %Exam{}}

      iex> update_exam(exam, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_exam(%Exam{} = exam, attrs) do
    exam
    |> Exam.changeset(attrs)
    |> Repo.update()
  end

  def update_class_student_exam(%ClassStudentExam{} = class_student_exam, attrs) do
    class_student_exam
    |> ClassStudentExam.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a exam.

  ## Examples

      iex> delete_exam(exam)
      {:ok, %Exam{}}

      iex> delete_exam(exam)
      {:error, %Ecto.Changeset{}}

  """
  def delete_exam(%Exam{} = exam) do
    Repo.delete(exam)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking exam changes.

  ## Examples

      iex> change_exam(exam)
      %Ecto.Changeset{source: %Exam{}}

  """
  def change_exam(%Exam{} = exam) do
    Exam.changeset(exam, %{})
  end

  def apply_exam_to_class(class_id, exam_id) do
    query = from cs in ClassStudent,
            where: cs.class_id == ^class_id,
            select: cs.id
    inserted_at =
      NaiveDateTime.utc_now()
      |> NaiveDateTime.truncate(:second)

    class_student_exams =
      Repo.all(query)
      |> Enum.map(fn class_student_id -> %{exam_id: exam_id, class_student_id: class_student_id, inserted_at: inserted_at, updated_at: inserted_at} end)

    Repo.insert_all(ClassStudentExam, class_student_exams, returning: true)
  end
end
