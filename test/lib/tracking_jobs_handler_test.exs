defmodule VerkWeb.TrackingJobsHandlerTest do
  use ExUnit.Case
  import VerkWeb.TrackingJobsHandler
  import :meck

  setup do
    on_exit fn -> unload() end
    :ok
  end

  describe "init/1" do
    test "returns correct initial state" do
      pid          = self()
      {:ok, state} = init(pid)
      assert state == {pid, %{finished: 0, failed: 0}}
    end
  end

  describe "handle_event/2" do
    test "with job finished event" do
      pid          = self()
      {:ok, state} = init(pid)

      assert handle_event(%Verk.Events.JobFinished{}, state) == {:ok, {pid, %{ finished: 1, failed: 0 }}}
      assert handle_event(%Verk.Events.JobFinished{}, {pid, %{finished: 10, failed: 0}}) == {:ok, {pid, %{ finished: 11, failed: 0 }}}
    end

    test "with job failed event" do
      pid          = self()
      {:ok, state} = init(pid)

      assert handle_event(%Verk.Events.JobFailed{}, state) == {:ok, {pid, %{ finished: 0, failed: 1 }}}
      assert handle_event(%Verk.Events.JobFailed{}, {pid, %{finished: 0, failed: 10}}) == {:ok, {pid, %{ finished: 0, failed: 11 }}}
    end

    test "with unexpected event" do
      pid          = self()
      {:ok, state} = init(pid)

      assert handle_event(:some_other_event, state) == {:ok, state}
    end
  end

  describe "handle_info/2" do
    test "broadcast_stats" do
      pid   = self()
      state = {pid, %{finished: 1, failed: 2}}

      {:ok, new_state} = handle_info(:broadcast_stats, state)
      assert new_state == {pid, %{finished: 0, failed: 0}}
      assert_receive {:stats, %{finished: 1, failed: 2}}
      assert_receive :broadcast_stats, 2000
    end

    test "unexpected info call" do
      {:ok, state} = handle_info(:something, :state)
      assert state == :state
    end
  end
end
