defmodule Writing.UserTest do
  use Writing.ModelCase

  alias Writing.User

  @valid_attrs %{email: "me@example.com", password: "foobarsoap"}
  @invalid_attrs %{email: "me", password: "1234567"}

  test "valid e-mail address and password" do
    changeset = User.changeset(%User{}, %{
      email: "joe@example.com",
      password: "1lh2bj1rjbk2"
    })

    assert changeset.valid?
  end

  test "email needs to contain an @" do
    changeset = User.changeset(%User{}, %{
      email: "joe",
      password: "1lh2bj1rjbk2"
    })

    refute changeset.valid?
  end

  test "password has to be at least 8 characters" do
    changeset = User.changeset(%User{}, %{
      email: "joe@example.com",
      password: "1234567"
    })

    refute changeset.valid?
  end
end
