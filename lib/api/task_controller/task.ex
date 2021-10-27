defmodule Todolist.TaskController.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "task" do
    field :task_description, :string
    field :status, :integer
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:task_description, :status, :user_id])
    |> validate_required([:task_description, :status, :user_id])
  end
end
