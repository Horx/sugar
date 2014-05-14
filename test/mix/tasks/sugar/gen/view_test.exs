defmodule Mix.Tasks.Sugar.Gen.ViewTest do
  use ExUnit.Case, async: true

  test "run_detached/1" do
    assigns = [
      app: :test_app,
      module: "TestApp",
      path: "test/fixtures"
    ]
    Mix.Tasks.Sugar.Gen.View.run_detached(assigns ++ [name: "main"])
    expected_path = "test/fixtures/views/main.html.eex"

    assert File.exists?(expected_path) === true
    File.rm! expected_path
  end

  test "run/1 with proper name" do
    args = ["main", "--path=test/fixtures"]
    Mix.Tasks.Sugar.Gen.View.run(args)
    expected_path = "test/fixtures/views/main.html.eex"

    assert File.exists?(expected_path) === true
    File.rm! expected_path
  end

  test "run/1 with no name" do
    args = ["--path=test/fixtures"]
    assert_raise Mix.Error, fn ->
      Mix.Tasks.Sugar.Gen.View.run(args)
    end
  end

  test "run/1 with improper name" do
    args = ["main/bad", "--path=test/fixtures"]
    assert_raise Mix.Error, fn ->
      Mix.Tasks.Sugar.Gen.View.run(args)
    end
  end
end
