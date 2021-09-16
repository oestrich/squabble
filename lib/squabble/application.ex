defmodule Squabble.Application do
  use Application

  def start(_type, _args) do
    children = [
      %{
        id: :pg,
        start: {:pg, :start_link, []}
      }
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Squabble.Supervisor)
  end
end
