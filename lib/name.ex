defmodule Flexi.Name do
  def as_exunit_opts(pattern \\ "") do
    cases = pattern |> matchingcases()

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
      |> Enum.uniq

    {opts, files}
  end

  def matchingcases(pattern \\ "") do
    testcases()
    |> Enum.filter(fn testcase ->
      testcase.name |> Atom.to_string() |> String.contains?(pattern)
    end)
  end

  def testcases do
    testmodules()
    |> Enum.flat_map(fn x -> x |> apply(:__ex_unit__, []) |> Map.get(:tests) end)
  end

  def testmodules do
    :code.all_loaded()
    |> Enum.map(fn {at, _} -> at end)
    |> Enum.filter(fn x -> :erlang.function_exported(x, :__ex_unit__, 0) end)
  end
end
