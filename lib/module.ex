defmodule Flexirunner.Module do
  def get(pattern \\ "") do
    pattern = String.downcase(pattern)

    modules =
      Flexirunner.Name.testmodules()
      |> Enum.filter(fn x ->
        matches?(x, pattern)
      end)

    cases = testcases(modules)

    files =
      cases
      |> Enum.map(fn testcase ->
        testcase |> Map.get(:tags) |> Map.get(:file)
      end)

    files |> Enum.uniq()
  end

  def testcases(modules) do
    modules
    |> Enum.flat_map(fn x -> x |> apply(:__ex_unit__, []) |> Map.get(:tests) end)
  end

  defp matches?(module, pattern) do
    module
    |> Atom.to_string()
    |> String.downcase()
    |> String.contains?(pattern)
  end
end
