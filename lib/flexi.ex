defmodule Flexi do
  alias Flexi.Reloader
  @doc """
  grep tests by pattern matching file names
  """
  def filematch(pattern \\ "") do
    files = pattern |> Flexi.File.matchingfiles()
    ExUnit.configure [only_test_ids: nil] # this removes the filters from (possible) previous runs

    run([trace: true], fn ->
      files |> Enum.each(&reload/1)
    end)
  end

  @doc """
  grep tests by pattern matching test names
  """
  def namematch(pattern \\ "") do
    {only_test_ids, files} = pattern |> Flexi.Name.as_exunit_opts()
    load_all_modules_if_needed(files)
    opts = [trace: true, only_test_ids: only_test_ids]

    run(opts, fn ->
      files |> Enum.each(&reload/1)
    end)
  end

  @doc """
  grep tests by pattern matching module names
  """
  def modulematch(pattern \\ "") do
    {only_test_ids, files} = pattern |> Flexi.Module.as_exunit_opts()
    load_all_modules_if_needed(files)
    opts = [trace: true, only_test_ids: only_test_ids]

    run(opts, fn ->
      files |> Enum.each(&reload/1)
    end)
  end

  @doc """
  generic function to execute tests with some desired parameters
  """
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
    Reloader.reload_file(file)
  end

  defp load_all_modules_if_needed(files) do
    if files == [] do
      if Flexi.Name.as_exunit_opts("") |> elem(1) == [] do
        IO.puts "******* You have no test files in memory yet, dropping filter get load them all ***********"
        filematch()
      end
    end
  end
end
