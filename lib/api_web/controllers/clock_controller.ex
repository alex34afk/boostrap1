defmodule TodolistWeb.ClockController do
  use TodolistWeb, :controller

  alias Todolist.ClockController
  alias Todolist.ClockController.Clock

  action_fallback TodolistWeb.FallbackController

  def index(conn, _params) do
    clocks = ClockController.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def create(conn, %{"clock" => clock_params}) do
    with {:ok, %Clock{} = clock} <- ClockController.create_clock(clock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.clock_path(conn, :show, clock))
      |> render("show.json", clock: clock)
    end
  end

  def show(conn, %{"clockID" => id}) do
    clock = ClockController.get_clock!(id)
    render(conn, "show.json", clock: clock)
  end

  def update(conn, %{"clockID" => id, "clock" => clock_params}) do
    clock = ClockController.get_clock!(id)

    with {:ok, %Clock{} = clock} <- ClockController.update_clock(clock, clock_params) do
      render(conn, "show.json", clock: clock)
    end
  end

  def delete(conn, %{"clockID" => id}) do
    clock = ClockController.get_clock!(id)

    with {:ok, %Clock{}} <- ClockController.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end
