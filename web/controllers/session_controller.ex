defmodule Writing.SessionController do
  use Writing.Web, :controller

  def index(conn, _params) do
    conn
    |> json(%{status: "Ok"})
  end
end
