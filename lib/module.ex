defmodule Flexi.Module do
  alias Flexi.Common

  def as_exunit_opts(pattern \\ "") do
    pattern = String.downcase(pattern)

    modules =
      Common.testmodules()
      |> Enum.filter(fn x ->
        matches?(x, pattern)
      end)

    cases = Common.collect_cases(modules)
    opts = Flexi.Common.exunit_opts_from_cases(cases)

    files =
      cases
      |> Enum.map(fn testcase ->
        testcase |> Map.get(:tags) |> Map.get(:file)
      end)
      |> Enum.uniq()

    {opts, files}
  end

  defp matches?(module, pattern) do
    module
    |> Atom.to_string()
    |> String.downcase()
    |> String.contains?(pattern)
  end
end
