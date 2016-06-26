defmodule Writing.Router do
  use Writing.Web, :router

  pipeline :api do
    plug :accepts, ["json", "json-api"]
  end

  scope "/", Writing do
    pipe_through :api
    resources "session", SessionController, only: [:index]
  end
end
