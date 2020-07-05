defmodule ClassManagementApiWeb.Router do
  use ClassManagementApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ClassManagementApiWeb do
    pipe_through :api

    resources "/teachers", TeacherController, except: [:new, :edit]
    resources "/students", StudentController, except: [:new, :edit]
    resources "/classes", ClassController, except: [:new, :edit] do
      post "/enroll-student", ClassController, :enroll_student
      get "/students", StudentController, :index_class_students
    end
    resources "/exams", ExamController, except: [:new, :edit]
  end
end
