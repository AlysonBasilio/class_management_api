defmodule ClassManagementApiWeb.Router do
  use ClassManagementApiWeb, :router

  pipeline :unauthenticated_api do
    plug :accepts, ["json"]
  end

  scope "/api", ClassManagementApiWeb do
    pipe_through :unauthenticated_api

    post "/generate-token", TokenController, :create
  end

  pipeline :authenticated_api do
    plug :accepts, ["json"]
    plug ClassManagementApiWeb.JwtAuthPlug
  end

  scope "/api", ClassManagementApiWeb do
    pipe_through :authenticated_api

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
