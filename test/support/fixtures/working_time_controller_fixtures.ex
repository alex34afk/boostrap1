defmodule Todolist.WorkingTimeControllerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Todolist.WorkingTimeController` context.
  """

  @doc """
  Generate a working_time.
  """
  def working_time_fixture(attrs \\ %{}) do
    {:ok, working_time} =
      attrs
      |> Enum.into(%{
        end: ~N[2021-10-24 14:54:00],
        start: ~N[2021-10-24 14:54:00]
      })
      |> Todolist.WorkingTimeController.create_working_time()

    working_time
  end
end
