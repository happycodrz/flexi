defmodule FlexiRealTest do
  use ExUnit.Case
  alias Flexi.Common

  defmodule EmptyRes do
    def testmodules do
      []
    end
  end

  defmodule TwoModules do
    def testmodules do
      [FlexiTest, FlexiTest2]
    end
  end

  test "no tests" do
    Application.put_env(:flexi, :realmodule, EmptyRes)
    assert Common.testcases() == []
    Application.delete_env(:flexi, :realmodule)
  end

  test "2 modules" do
    Application.put_env(:flexi, :realmodule, TwoModules)
    assert Common.testcases() |> Enum.count() == 7

    assert Common.testcases() |> Enum.map(fn x -> x.name end) == [
             :"test third one",
             :"test second one",
             :"test first one",
             :"test 4th one",
             :"test third one",
             :"test second one",
             :"test first one"
           ]

    Application.delete_env(:flexi, :realmodule)
  end

  describe "Flexi.File" do
    test "matchingfiles" do
      assert Flexi.File.matchingfiles("real") == ["test/test_helper.exs", "test/real_test.exs"]
      assert Flexi.File.matchingfiles("") == ["test/test_helper.exs", "test/flexi_test.exs", "test/real_test.exs"]
      assert Flexi.File.matchingfiles("flexi") == ["test/test_helper.exs", "test/flexi_test.exs"]
    end
  end

  describe "Flexi.Module" do
    test "matching_modules" do
      Application.put_env(:flexi, :realmodule, TwoModules)
      assert Flexi.Module.matching_modules("2") == [FlexiTest2]
      assert Flexi.Module.matching_modules("FlexiTest") == [FlexiTest, FlexiTest2]
      assert Flexi.Module.matching_modules("") == [FlexiTest, FlexiTest2]
      Application.delete_env(:flexi, :realmodule)
    end

    test "as_exunit_opts" do
      Application.put_env(:flexi, :realmodule, TwoModules)

      assert Flexi.Module.as_exunit_opts("2") |> elem(0) ==
               MapSet.new([
                 {FlexiTest2, :"test 4th one"},
                 {FlexiTest2, :"test first one"},
                 {FlexiTest2, :"test second one"},
                 {FlexiTest2, :"test third one"}
               ])

      assert Flexi.Module.as_exunit_opts("") |> elem(0) ==
               MapSet.new([
                 {FlexiTest, :"test first one"},
                 {FlexiTest, :"test second one"},
                 {FlexiTest, :"test third one"},
                 {FlexiTest2, :"test 4th one"},
                 {FlexiTest2, :"test first one"},
                 {FlexiTest2, :"test second one"},
                 {FlexiTest2, :"test third one"}
               ])

      Application.delete_env(:flexi, :realmodule)
    end
  end
end
