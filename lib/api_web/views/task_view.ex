defmodule TodolistWeb.TaskView do
  use TodolistWeb, :view
  alias TodolistWeb.TaskView

  def render("index.json", %{tasks: tasks}) do
    %{data: render_many(tasks, TaskView, "task.json")}
  end

  def render("show.json", %{task: task}) do
    %{data: render_one(task, TaskView, "task.json")}
  end

  def render("task.json", %{task: task}) do
    %{
      id: task.id,
      task_description: task.task_description,
      status: task.status,
      user_id: task.user_id
    }
  end
end
