require IEx;

defmodule Todo do
  use GenServer

  ## Client side code
  def start(tasks \\ "") do
   {:ok, pid} = GenServer.start(__MODULE__, tasks)
   pid
  end

  def add_task(pid, task) do
    GenServer.cast(pid, {:add, task})
  end

  def remove_task(pid, task) do
    GenServer.cast(pid, {:remove, task})
  end

  def all_tasks(pid) do
    GenServer.call(pid, :all)
  end

  ## Server side code:

  def handle_cast({:add, task}, tasks) do
    {:noreply, tasks <> " | " <>  task}
  end

  def handle_cast({:remove, task}, tasks) do
    {:noreply, tasks |> String.replace("| #{task}", "")}
  end

  def handle_call(:all, _from,  tasks) do
    {:reply, tasks, tasks}
  end
end

# pid = Todo.start
# Todo.add_task(pid, "Make eggs")
# Todo.all_tasks(pid)

## TODO
  # Ask user for what it wants to do.
