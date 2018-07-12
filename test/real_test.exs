defmodule FlexiRealTest do
  use ExUnit.Case
  import Mockery

  test "no tests" do
    mock(Flexi.CommonMockable, :testmodules, [])
    assert Flexi.Common.testcases() == []
  end

  test "2 modules" do
    mock(Flexi.CommonMockable, :testmodules, [FlexiTest, FlexiTest2])
    assert Flexi.Common.testcases() |> Enum.count() == 7

    assert Flexi.Common.testcases() |> Enum.map(fn x -> x.name end) == [
             :"test third one",
             :"test second one",
             :"test first one",
             :"test 4th one",
             :"test third one",
             :"test second one",
             :"test first one"
           ]
  end

  describe "Flexi.File" do
    test "matchingfiles" do
      assert Flexi.File.matchingfiles("real") == ["test/real_test.exs"]
      assert Flexi.File.matchingfiles("") == ["test/flexi_test.exs", "test/real_test.exs"]
      assert Flexi.File.matchingfiles("flexi") == ["test/flexi_test.exs"]
    end
  end

  describe "Flexi.Module" do
    test "matching_modules" do
      mock(Flexi.CommonMockable, :testmodules, [FlexiTest, FlexiTest2])
      assert Flexi.Module.matching_modules("2") == [FlexiTest2]
      assert Flexi.Module.matching_modules("FlexiTest") == [FlexiTest, FlexiTest2]
      assert Flexi.Module.matching_modules("") == [FlexiTest, FlexiTest2]
    end

    test "as_exunit_opts" do
      mock(Flexi.CommonMockable, :testmodules, [FlexiTest, FlexiTest2])

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
    end
  end
end
