defmodule ClassManagementApiWeb.ExamView do
  use ClassManagementApiWeb, :view
  alias ClassManagementApiWeb.ExamView

  def render("index.json", %{exams: exams}) do
    %{data: render_many(exams, ExamView, "exam.json")}
  end

  def render("show.json", %{exam: exam}) do
    %{data: render_one(exam, ExamView, "exam.json")}
  end

  def render("exam.json", %{exam: exam}) do
    %{id: exam.id,
      subject: exam.subject,
      type: exam.type,
      teacher_id: exam.teacher_id}
  end
end
