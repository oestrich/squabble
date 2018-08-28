# Squabble

A simple leader election. Pulled from [ExVenture](https://github.com/oestrich/ex_venture).

## What is this doing?

Squabble starts once on each node and uses [Raft](https://raft.github.io/) leadership election amongst all of the nodes. When a leader is selected, callback modules are called on that you supply. This lets you kick off a process _once_ in your cluster anytime cluster state changes.

This is used in ExVenture to boot the virtual world, for instance.

Two callbacks are currently provided as seen below, when a new leader is selected and also when a node goes down. ExVenture uses both of these to rebalace the world across the still running cluster.

## Installation

Install via hex.

```elixir
def deps do
  [
    {:libcluster, "~> 3.0"},
    {:squabble, "~> 0.1.0"},
  ]
end
```

In order to connect multiple nodes you should also set up [libcluster](https://github.com/bitwalker/libcluster).

## Leader Notifications

Squabble will a call a module on the node when the leader node is selected. This is a behaviour. See a sample below.

```elixir
defmodule MyApp.Leader do
  @behaviour Squabble.Leader

  @impl true
  def leader_selected(term) do
  end

  @impl true
  def node_down() do
  end
end
```

## Configuration

Configure Squabble when you start the worker in your supervision tree. This should go _after_ `libcluster` if you're using that. All nodes should be connected before starting Squabble.

```elixir
children = [
  {Squabble, [subscriptions: [MyApp.Leader], size: 1}
]
```
