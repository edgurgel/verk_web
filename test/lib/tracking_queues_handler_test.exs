defmodule VerkWeb.TrackingQueuesHandlerTest do
  use ExUnit.Case
  import VerkWeb.TrackingQueuesHandler
  import :meck

  setup do
    on_exit fn -> unload() end
    :ok
  end

  describe "init/1" do
    test "returns correct initial state" do
      pid = self()
      assert {:consumer, ^pid, subscribe_to: [Verk.EventProducer]} = init(pid)
    end
  end

  describe "handle_events/3" do
    test "QueueRunning event" do
      pid = self()
      event = %Verk.Events.QueueRunning{queue: "default"}
      handle_events([event], :from, pid)
      assert_receive {:queue_status, %{queue: "default", status: "running"}}
    end

    test "QueuePausing event" do
      pid = self()
      event = %Verk.Events.QueuePausing{queue: "default"}
      handle_events([event], :from, pid)
      assert_receive {:queue_status, %{queue: "default", status: "pausing"}}
    end

    test "QueuePaused event" do
      pid = self()
      event = %Verk.Events.QueuePaused{queue: "default"}
      handle_events([event], :from, pid)
      assert_receive {:queue_status, %{queue: "default", status: "paused"}}
    end

    test "unknown event" do
      pid = self()
      event = %{queue: "default"}
      handle_events([event], :from, pid)
      refute_receive {:queue_status, _}
    end
  end
end
