defmodule Flexi.Common do
  @moduledoc """
  shared functions
  """
  import Mockery.Macro
  alias Flexi.CommonMockable

  def testcases do
    testmodules() |> collect_cases()
  end

  @doc """
  all discovereable test modules
  this is mocked in tests for easier testing
  """
  def testmodules do
    mockable(CommonMockable).testmodules()
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
