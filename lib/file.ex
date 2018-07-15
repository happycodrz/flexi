defmodule Flexi.File do
  alias Flexi.Common
  @moduledoc """
  functions for file-related filtering
  """

  @doc """
  test files matching a particular pattern
  """
  def matchingfiles(pattern) do
    "test" |> Path.join("**/*_test.exs") |> Path.wildcard()
    |> Enum.filter(fn x -> String.contains?(x, pattern) end)
    |> Common.with_testhelpers()
  end
end
