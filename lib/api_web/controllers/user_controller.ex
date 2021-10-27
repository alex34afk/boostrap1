defmodule TodolistWeb.UserController do
  use TodolistWeb, :controller

  alias Todolist.UserController
  alias Todolist.UserController.User

  action_fallback TodolistWeb.FallbackController

  def index(conn, _params) do
    users = UserController.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- UserController.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"userID" => id}) do
    user = UserController.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"userID" => id, "user" => user_params}) do
    user = UserController.get_user!(id)

    with {:ok, %User{} = user} <- UserController.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"userID" => id}) do
    user = UserController.get_user!(id)

    with {:ok, %User{}} <- UserController.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
