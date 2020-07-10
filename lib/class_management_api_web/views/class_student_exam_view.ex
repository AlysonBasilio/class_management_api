defmodule ClassManagementApiWeb.ClassStudentExamView do
  use ClassManagementApiWeb, :view
  alias ClassManagementApiWeb.ClassStudentExamView

  def render("index.json", %{class_student_exams: class_student_exams}) do
    %{data: render_many(class_student_exams, ClassStudentExamView, "class_student_exam.json")}
  end

  def render("show.json", %{class_student_exam: class_student_exam}) do
    %{data: render_one(class_student_exam, ClassStudentExamView, "class_student_exam.json")}
  end

  def render("class_student_exam.json", %{class_student_exam: class_student_exam}) do
    %{id: class_student_exam.id,
      status: class_student_exam.status,
      class_student_id: class_student_exam.class_student_id,
      exam_id: class_student_exam.exam_id}
  end
end
