defmodule Flexi.Common do
  @moduledoc """
  shared functions
  """

  def testcases do
    testmodules() |> collect_cases()
  end

  @doc """
  all discoverable test modules (mocked in tests for easier testing)
  """
  def testmodules do
    realmodule().testmodules()
  end

  defp realmodule do
    Application.get_env(:flexi, :realmodule, Flexi.CommonMockable)
  end

  def collect_cases(modules) do
    modules |> Enum.flat_map(fn x -> x |> apply(:__ex_unit__, []) |> Map.get(:tests) end)
  end

  def exunit_opts_from_cases(cases) do
    cases
    |> Enum.map(fn testcase ->
      {testcase.module, testcase.name}
    end)
    |> MapSet.new()
  end

  def with_testhelpers(paths) do
    test_helpers(paths) ++ paths
  end

  defp test_helpers(paths) do
    paths |> Enum.map(&test_helper/1) |> Enum.uniq
  end

  defp test_helper(path) do
    if Mix.Project.umbrella? do
      app_name =
        path
        |> Path.relative_to_cwd
        |> String.split("/")
        |> Enum.at(1)

      "apps/#{app_name}/test/test_helper.exs"
    else
      "test/test_helper.exs"
    end
  end
end

defmodule Flexi.CommonMockable do
  @moduledoc """
  in a separate module to easily mock `testmodules` function
  """
  def testmodules do
    :code.all_loaded()
    |> Enum.map(fn {at, _} -> at end)
    |> Enum.filter(fn x -> :erlang.function_exported(x, :__ex_unit__, 0) end)
  end
end
