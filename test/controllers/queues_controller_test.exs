defmodule VerkWeb.QueuesControllerTest do
  use VerkWeb.ConnCase
  import :meck, except: [delete: 3]
  alias Verk.QueueStats

  @stats [%{ queue: "default", running_counter: 1,
             finished_counter: 1, failed_counter: 0 }]

  setup do
    new QueueStats
    on_exit fn -> unload() end
    :ok
  end

  describe "GET /" do
    test "no query string", %{conn: conn} do
      expect(QueueStats, :all, [""], @stats)

      conn = get conn, "/queues"
      assert html_response(conn, 200) =~ "Queues"

      validate(QueueStats)
    end

    test "with a query string", %{conn: conn} do
      expect(QueueStats, :all, ["defa"], @stats)

      conn = get conn, "/queues?search=defa"
      assert html_response(conn, 200) =~ "Queues"

      validate(QueueStats)
    end

    test "with no queues running", %{conn: conn} do
      expect(QueueStats, :all, [""], [])

      conn = get conn, "/queues"
      assert html_response(conn, 200) =~ "No job was started yet"

      validate(QueueStats)
    end
  end
end
