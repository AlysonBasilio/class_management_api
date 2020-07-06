defmodule ClassManagementApiWeb.TokenController do
  use ClassManagementApiWeb, :controller

  alias ClassManagementApiWeb.JwtAuthToken

  action_fallback ClassManagementApiWeb.FallbackController

  def create(conn, _params) do
    conn
    |> put_status(:created)
    |> render("token.json", token: JwtAuthToken.generate())
  end
end
