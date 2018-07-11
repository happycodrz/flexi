defmodule Flexi do
  @doc """
  :matchfile
  """
  def matchfile(pattern \\ "") do
    files = pattern |> Flexi.File.matchingfiles()

    run([trace: true], fn ->
      files |> Enum.each(&reload/1)
    end)
  end

  @doc """
  :matchname
  """
  def matchname(pattern \\ "") do
    {only_test_ids, files} = pattern |> Flexi.Name.as_exunit_opts()
    opts = [trace: true, only_test_ids: only_test_ids]

    run(opts, fn ->
      files |> Enum.each(&reload/1)
    end)
  end

  @doc """
  :matchmodule
  """
  def matchmodule(pattern \\ "") do
    {only_test_ids, files} = pattern |> Flexi.Module.as_exunit_opts()
    opts = [trace: true, only_test_ids: only_test_ids]

    run(opts, fn ->
      files |> Enum.each(&reload/1)
    end)
  end

  def run(opts, fun) do
    ExUnit.start(opts)
    fun.()
    task = Task.async(ExUnit, :run, [])
    test_modules_loaded()
    Task.await(task, :infinity)
  end

  if function_exported?(ExUnit.Server, :cases_loaded, 0) do
    defp test_modules_loaded, do: ExUnit.Server.cases_loaded()
  else
    defp test_modules_loaded, do: ExUnit.Server.modules_loaded()
  end

  defp reload(file) do
    Cortex.Reloader.reload_file(file)
  end
end
