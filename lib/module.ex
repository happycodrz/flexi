defmodule Flexi.Module do
  def as_exunit_opts(pattern \\ "") do
    pattern = String.downcase(pattern)

    modules =
      Flexi.Name.testmodules()
      |> Enum.filter(fn x ->
        matches?(x, pattern)
      end)

    cases = testcases(modules)

    opts =
      cases
      |> Enum.map(fn testcase ->
        {testcase.module, testcase.name}
      end)
      |> MapSet.new()

    files =
      cases
      |> Enum.map(fn testcase ->
        testcase |> Map.get(:tags) |> Map.get(:file)
      end)
      |> Enum.uniq()

    {opts, files}
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
