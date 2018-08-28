defmodule Squabble.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Squabble, []},
    ]

    opts = [strategy: :one_for_one, name: Squabble.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
