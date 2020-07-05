defmodule ClassManagementApiWeb.Router do
  use ClassManagementApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ClassManagementApiWeb do
    pipe_through :api

    resources "/class-student-exam", ClassStudentExamController, except: [:new, :edit, :create, :delete, :index, :show]
    resources "/classes", ClassController, except: [:new, :edit] do
      post "/apply-exam", ClassStudentExamController, :apply_exam_to_class
      post "/enroll-student", ClassController, :enroll_student
      get "/students", StudentController, :index_class_students
    end
    resources "/teachers", TeacherController, except: [:new, :edit]
    resources "/students", StudentController, except: [:new, :edit]
    resources "/exams", ExamController, except: [:new, :edit]
  end
end
