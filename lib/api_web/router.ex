defmodule TodolistWeb.Router do
  use TodolistWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TodolistWeb do
    pipe_through :api
  end

  scope "/api/clocks", TodolistWeb do
    pipe_through [:api]
    get "/:userID/_list", ClockController, :index
    get "/:userID/:clockID", ClockController, :show
    post "/:userID/", ClockController, :create
    delete "/:userID/:clockID", ClockController, :delete
    put "/:userID/:clockID", ClockController, :update
  end


  scope "/api/tasks", TodolistWeb do
    pipe_through [:api]
    get "/:userID/_list", TaskController, :index
    get "/:userID/:taskID", TaskController, :show
    post "/:userID/", TaskController, :create
    delete "/:userID/:taskID", TaskController, :delete
    put "/:userID/:taskID", TaskController, :update
  end

  scope "/api/user", TodolistWeb do
    pipe_through [:api]
    get "/_list", UserController, :index
    get "/:userID/", UserController, :show
    post "/:userID/", UserController, :create
    delete "/:userID/", UserController, :delete
    put "/:userID/", UserController, :update
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router
    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: TodolistWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
