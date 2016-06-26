defmodule Writing.Router do
  use Writing.Web, :router

  pipeline :api do
    plug :accepts, ["json", "json-api"]
  end

  scope "/", Writing do
    pipe_through :api
    post "register", RegistrationController, :create
    post "token", SessionController, :create, as: :login
  end
end
