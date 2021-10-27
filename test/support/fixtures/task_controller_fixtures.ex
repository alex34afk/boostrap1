defmodule Todolist.TaskControllerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Todolist.TaskController` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        description: "some description",
        status: 42,
        title: "some title",
        user_id: 42
      })
      |> Todolist.TaskController.create_task()

    task
  end
end
