defmodule InTouchWeb.Router do
  use InTouchWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :auth do
    plug InTouchWeb.SessionPlug
  end

  pipeline :no_session do
    plug InTouchWeb.NoSessionPlug
  end

  scope "/", InTouchWeb do
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
      resources "/chats", ChatController, only: [:index, :create, :show]
    end
  end
end
