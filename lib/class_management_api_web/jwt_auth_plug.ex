defmodule ClassManagementApiWeb.JwtAuthPlug do
  import Plug.Conn
  alias ClassManagementApiWeb.JwtAuthToken

  def init(opts), do: opts

  def call(conn, _opts) do
    case extract_token(conn) do
      { :ok, token } ->
        case JwtAuthToken.decode_and_validate(token) do
          { :ok, claims } ->
            conn |> success(claims)
          { :error, _error } ->
            conn |> forbidden
        end
      { :error, _error } ->
        conn |> forbidden
    end
  end

  defp extract_token(conn) do
    case Plug.Conn.get_req_header(conn, "authorization") do
      [auth_header] -> get_token_from_header(auth_header)
       _ -> {:error, :missing_auth_header}
    end
  end

  defp get_token_from_header(auth_header) do
    {:ok, reg} = Regex.compile("Bearer\:?\s+(.*)$", "i")
    case Regex.run(reg, auth_header) do
      [_, match] -> {:ok, String.trim(match)}
      _ -> {:error, "token not found"}
    end
  end

  defp success(conn, token_payload) do
    assign(conn, :claims, token_payload)
  end

  defp forbidden(conn) do
    conn
    |> put_status(:unauthorized)
    |> Phoenix.Controller.render(ClassManagementApiWeb.ErrorView, "401.json")
  end
end
