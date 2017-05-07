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
      pid = self()
      assert {:consumer, {^pid, %{finished: 0, failed: 0}}, subscribe_to: [Verk.EventProducer]} = init(pid)
    end
  end

  describe "handle_events/2" do
    test "with job finished event" do
      pid = self()
      {:consumer, state, subscribe_to: [Verk.EventProducer]} = init(pid)

      assert handle_events([%Verk.Events.JobFinished{}], :from, state) == {:noreply, [], {pid, %{ finished: 1, failed: 0 }}}
      assert handle_events([%Verk.Events.JobFinished{}], :from, {pid, %{finished: 10, failed: 0}}) == {:noreply, [], {pid, %{ finished: 11, failed: 0 }}}
    end

    test "with job failed event" do
      pid = self()
      {:consumer, state, subscribe_to: [Verk.EventProducer]} = init(pid)

      assert handle_events([%Verk.Events.JobFailed{}], :from, state) == {:noreply, [], {pid, %{ finished: 0, failed: 1 }}}
      assert handle_events([%Verk.Events.JobFailed{}], :from, {pid, %{finished: 0, failed: 10}}) == {:noreply, [], {pid, %{ finished: 0, failed: 11 }}}
    end

    test "with unexpected event" do
      pid = self()
      {:consumer, state, subscribe_to: [Verk.EventProducer]} = init(pid)

      assert handle_events([:some_other_event], :from, state) == {:noreply, [], state}
    end
  end

  describe "handle_info/2" do
    test "broadcast_stats" do
      pid   = self()
      state = {pid, %{finished: 1, failed: 2}}

      {:noreply, [], new_state} = handle_info(:broadcast_stats, state)
      assert new_state == {pid, %{finished: 0, failed: 0}}
      assert_receive {:stats, %{finished: 1, failed: 2}}
      assert_receive :broadcast_stats, 2000
    end

    test "unexpected info call" do
      {:noreply, [], state} = handle_info(:something, :state)
      assert state == :state
    end
  end
end
