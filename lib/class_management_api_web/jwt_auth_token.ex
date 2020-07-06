defmodule ClassManagementApiWeb.JwtAuthToken do
  use Joken.Config

  def generate do
    {:ok, token, _token_with_default_claims} = generate_and_sign()

    token
  end

  def decode_and_validate(jwt_string) do
    jwt_string
    |> verify_and_validate()
  end
end
