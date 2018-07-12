defmodule Flexi.Name do
  @moduledoc """
  functions related to filtering by test name
  """
  alias Flexi.Common
  def as_exunit_opts(pattern \\ "") do
    cases = pattern |> matchingcases()
    opts = Common.exunit_opts_from_cases(cases)

    files =
      cases
      |> Enum.map(fn testcase ->
        testcase |> Map.get(:tags) |> Map.get(:file)
      end)
      |> Enum.uniq()

    {opts, files}
  end

  def matchingcases(pattern \\ "") do
    Common.testcases()
    |> Enum.filter(fn testcase ->
      testcase.name |> Atom.to_string() |> String.contains?(pattern)
    end)
  end
end
