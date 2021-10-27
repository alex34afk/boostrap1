defmodule Todolist.TaskControllerTest do
  use Todolist.DataCase

  alias Todolist.TaskController

  describe "tasks" do
    alias Todolist.TaskController.Task

    import Todolist.TaskControllerFixtures

    @invalid_attrs %{description: nil, status: nil, title: nil, user_id: nil}

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert TaskController.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert TaskController.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      valid_attrs = %{description: "some description", status: 42, title: "some title", user_id: 42}

      assert {:ok, %Task{} = task} = TaskController.create_task(valid_attrs)
      assert task.description == "some description"
      assert task.status == 42
      assert task.title == "some title"
      assert task.user_id == 42
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TaskController.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      update_attrs = %{description: "some updated description", status: 43, title: "some updated title", user_id: 43}

      assert {:ok, %Task{} = task} = TaskController.update_task(task, update_attrs)
      assert task.description == "some updated description"
      assert task.status == 43
      assert task.title == "some updated title"
      assert task.user_id == 43
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = TaskController.update_task(task, @invalid_attrs)
      assert task == TaskController.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = TaskController.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> TaskController.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = TaskController.change_task(task)
    end
  end
end
