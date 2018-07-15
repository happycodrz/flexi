defmodule Flexi.Application do
  alias Flexi.Reloader
  use Application
  import Supervisor.Spec, warn: false

  def start(_type, _args) do
    cond do
      Mix.env in [:dev, :test] ->
        children = [worker(Reloader, [])]
        Supervisor.start_link(children, strategy: :one_for_one, name: Flexi.Supervisor)

      true ->
        {:error, "Only :dev and :test environments are allowed"}
    end
  end
end
