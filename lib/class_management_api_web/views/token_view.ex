defmodule ClassManagementApiWeb.TokenView do
  use ClassManagementApiWeb, :view

  def render("token.json", %{token: token}) do
    %{token: token}
  end
end
