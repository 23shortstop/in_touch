defmodule BoAppWeb.Router do
  use BoAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :auth do
    plug BoAppWeb.SessionPlug
  end

  pipeline :no_session do
    plug BoAppWeb.NoSessionPlug
  end

  scope "/", BoAppWeb do
    pipe_through :browser

    get "/", PageController, :index

    scope "/" do
    pipe_through :no_session
      resources "/users", UserController, only: [:new, :create]
      resources "/sessions", SessionController, only: [:new, :create]
    end

    scope "/" do
      pipe_through :auth

      resources "/users", UserController, only: [:index]
      resources "/sessions", SessionController, only: [:delete], singleton: true
    end
  end
end
