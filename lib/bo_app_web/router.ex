defmodule BoAppWeb.Router do
  use BoAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BoAppWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/chat", BoAppWeb do
    pipe_through :browser

    resources "/users", UserController, except: [:show]
  end

  # Other scopes may use custom stacks.
  # scope "/api", BoAppWeb do
  #   pipe_through :api
  # end
end
