defmodule ClassManagementApi.Repo do
  use Ecto.Repo,
    otp_app: :class_management_api,
    adapter: Ecto.Adapters.Postgres
end
