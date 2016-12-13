defmodule VerkWeb.TrackingJobsHandlerTest do
  use ExUnit.Case
  import VerkWeb.TrackingJobsHandler
  import :meck

  setup do
    on_exit fn -> unload end
    :ok
  end

  describe "init/1" do
    test "returns correct initial state" do
      {:ok, state} = init([])
      assert state == %{finished: 0, failed: 0}
    end
  end

  describe "handle_event/2" do
    test "with job finished event" do
      {:ok, state} = init([])

      assert handle_event(%Verk.Events.JobFinished{}, state) == {:ok, %{ finished: 1, failed: 0 }}
      assert handle_event(%Verk.Events.JobFinished{}, %{finished: 10, failed: 0}) == {:ok, %{ finished: 11, failed: 0 }}
    end

    test "with job failed event" do
      {:ok, state} = init([])

      assert handle_event(%Verk.Events.JobFailed{}, state) == {:ok, %{ finished: 0, failed: 1 }}
      assert handle_event(%Verk.Events.JobFailed{}, %{finished: 0, failed: 10}) == {:ok, %{ finished: 0, failed: 11 }}
    end

    test "with unexpected event" do
      {:ok, state} = init([])

      assert handle_event(:some_other_event, state) == {:ok, state}
    end
  end

  describe "handle_info/2" do
    test "broadcast_stats" do
      state = %{finished: 1, failed: 2}

      expect(VerkWeb.Endpoint, :broadcast, ["rooms:jobs", "job:stats", state], {:ok})
      expect(Process, :send_after, [VerkWeb.TrackingJobsHandler, "rooms:jobs", 1000], {:ok})

      {:ok, new_state} = handle_info(:broadcast_stats, state)
      assert new_state == %{finished: 0, failed: 0}
    end

    test "unexpected info call" do
      {:ok, state} = handle_info(:something, :state)
      assert state == :state
    end
  end

  describe "handle_call/2" do
    test "current_stats returns current state" do
      {:ok, state_1, state_2} = handle_call(:current_stats, %{finished: 1, failed: 10})

      assert state_1 == %{finished: 1, failed: 10}
      assert state_2 == %{finished: 1, failed: 10}
    end
  end
end
