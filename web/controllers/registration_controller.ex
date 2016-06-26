defmodule Writing.RegistrationController do
  use Writing.Web, :controller

  alias Writing.User

  def create(conn, %{
    "data" => %{
      "type" => "users",
      "attributes" => %{
        "email" => email,
        "password" => password
      }
    }
  }) do
    changeset = User.changeset %User{}, %{
      email: email,
      password: password
    }

    case Repo.insert changeset do
      {:ok, user}->
        conn
        |> put_status(:created)
        |> render(Writing.UserView, "show.json", user: user)
      {:error, changeset}->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Writing.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
