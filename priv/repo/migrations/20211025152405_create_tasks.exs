defmodule Todolist.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :task_description, :string
      add :status, :integer
      add :user_id, :integer

      timestamps()
    end
  end
end
