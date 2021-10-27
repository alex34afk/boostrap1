defmodule TodolistWeb.TaskController do
  use TodolistWeb, :controller

  alias Todolist.TaskController
  alias Todolist.TaskController.Task

  action_fallback TodolistWeb.FallbackController

  def index(conn, _params) do
    task = TaskController.list_tasks()
    render(conn, "index.json", tasks: task)
  end

  def create(conn, %{"task" => task_params}) do
    with {:ok, %Task{} = task} <- TaskController.create_task(task_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.task_path(conn, :show, task))
      |> render("show.json", tasks: task)
    end
  end

  def show(conn, %{"taskID" => id}) do
    task = TaskController.get_task!(id)
    render(conn, "show.json", tasks: task)
  end

  def update(conn, %{"taskID" => id, "task" => task_params}) do
    task = TaskController.get_task!(id)
    with {:ok, %Task{} = task} <- TaskController.update_task(task, task_params) do
      render(conn, "show.json", tasks: task)
    end
  end

  def delete(conn, %{"taskID" => id}) do
    task = TaskController.get_task!(id)

    with {:ok, %Task{}} <- TaskController.delete_task(task) do
      send_resp(conn, :no_content, "")
    end
  end
end
