defmodule Flexirunner.File do
  def matchingfiles(pattern) do
    "test" |> Path.join("**/*_test.exs") |> Path.wildcard()
    |> Enum.filter(fn x -> String.contains?(x, pattern) end)
  end
end
