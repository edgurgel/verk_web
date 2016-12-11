defmodule VerkWeb.Plug.BasicAuth do
  @moduledoc """
  A plug for protecting verk_web with HTTP Basic Auth.
  The plug expects to be initialized with a keyword list with values for :username and :password.
  Routes using this plug will have the browser ask for username and password.
  If the username and password are correct, the user will be able to access the page.
  If not, the user will receive a 401, and re-asked for valid authentication.
  ## Example
  config :verk_web, authorization: [
    username: "o",
    password: "pass"
  ]
  """

  def init(options) do
    username = Keyword.fetch!(options, :username) |> to_value
    password = Keyword.fetch!(options, :password) |> to_value
    [username: username, password: password]
  end

  def call(conn, options) do
    auth_header = Plug.Conn.get_req_header(conn, "authorization")

    if valid_credentials?(auth_header, options) do
      conn
    else
      conn
      |> send_unauthorized_response()
    end
  end

  defp valid_credentials?(["Basic " <> encoded_string], options) do
    Base.decode64!(encoded_string) == "#{options[:username]}:#{options[:password]}"
  end

  defp valid_credentials?(_credentials, _options) do
    false
  end

  defp send_unauthorized_response(conn) do
    Plug.Conn.put_resp_header(conn, "www-authenticate", "Basic realm=\"Private\"")
    |> Plug.Conn.send_resp(401, "401 Unauthorized")
    |> Plug.Conn.halt
  end

  defp to_value({:system, env_var}), do: System.get_env(env_var)
  defp to_value(value), do: value
end