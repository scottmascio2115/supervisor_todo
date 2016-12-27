defmodule Todo.Server do
  use Supervisor

  def add_list(name) do
    # Calling it on Module makes certain we call
    # the singular process running based on the name see line 10

    # This will start a new process as a
    # child of this process with the name that is passed it
    Supervisor.start_child(__MODULE__, [name])
  end

  def find_list(name) do
    Enum.find(lists, fn(child) ->
      Todo.List.name(child) == name
    end)
  end

  def delete_list(list) do
    Supervisor.terminate_child(__MODULE__, list)
  end

  def lists do
    __MODULE__
    |> Supervisor.which_children
    |> Enum.map(fn({_, child, _, _}) -> child end)
  end

  ### Supervisor API
  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    children = [
      # this is called from supervisor.start_child
      # and passes name as the first arguement in the array
      # some freaking how
      worker(Todo.List, [], restart: :transient)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
  ###
end
