defmodule RegistrationControllerTest do
  use Writing.ConnCase

  alias Writing.User

  @valid_attrs %{
    email: "joe@example.com",
    password: "12345678"
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, registration_path(conn, :create), %{
      data: %{
        type: "users",
        attributes: @valid_attrs
      }
    }
    assert json_response(conn, 201)["data"]["uuid"]
    assert Repo.get_by(User, %{email: @valid_attrs[:email]})
  end
end
