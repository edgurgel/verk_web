defmodule VerkWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :verk_web

  socket("/socket", VerkWeb.UserSocket)

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.
  plug(Plug.Static,
    at: "/",
    from: :verk_web,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)
  )

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket("/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket)
    plug(Phoenix.LiveReloader)
    plug(Phoenix.CodeReloader)
  end

  plug(Plug.RequestId)
  plug(Plug.Logger)

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Jason
  )

  plug(Plug.MethodOverride)
  plug(Plug.Head)

  plug(Plug.Session,
    store: :ets,
    key: "verk_web_sid",
    table: :verk_web_session
  )

  auth_options = Application.get_env(:verk_web, :authorization)

  if auth_options do
    plug(Plug.BasicAuth, use_config: {:verk_web, :authorization})
  end

  plug(VerkWeb.Router)
end
