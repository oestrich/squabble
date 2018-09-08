# Squabble

A simple leader election. Pulled from [ExVenture](https://github.com/oestrich/ex_venture).

**Warning:** this has currently only been tested on low traffic production. It works, but may not stand up to _your_ production. I'd love to get it there though!

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
    {:squabble, git: "https://github.com/oestrich/squabble.git"},
  ]
end
```

In order to connect multiple nodes you should also set up [libcluster](https://github.com/bitwalker/libcluster).

## Configuration

Configure Squabble when you start the worker in your supervision tree. This should go _after_ `libcluster` if you're using that. All nodes should be connected before starting Squabble.

```elixir
children = [
  {Squabble, [subscriptions: [MyApp.Leader], size: 1]}
]
```

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
