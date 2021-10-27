defmodule Todolist.ClockControllerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Todolist.ClockController` context.
  """

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~N[2021-10-24 14:53:00]
      })
      |> Todolist.ClockController.create_clock()

    clock
  end
end
