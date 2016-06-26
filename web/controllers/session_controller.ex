defmodule Writing.SessionController do
  use Writing.Web, :controller

  import Ecto.Query, only: [where: 2]
  import Comeonin.Bcrypt
  import Logger

  alias Writing.User

  def create(conn, %{
    "grant_type" => "password",
    "username" => username,
    "password" => password
  }) do
    user = User
    |> where(email: ^username)
    |> Repo.one!
    cond do
      checkpw(password, user.password_hash) ->
        Logger.info "User " <> username <> " just logged in"
        {:ok, jwt, _} = Guardian.encode_and_sign(user, :token)
        conn
        |> json(%{access_token: jwt, uuid: user.uuid})
      true ->
        Logger.warn "User " <> username <> " just failed to login"
        conn
        |> put_status(401)
        |> render(Writing.ErrorView, "401.json") # 401
    end
  end

  def create(_, %{ "grant_type" => _}) do
    throw "Unsupported grant_type"
  end
end
