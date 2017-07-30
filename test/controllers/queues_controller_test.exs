defmodule VerkWeb.QueuesControllerTest do
  use VerkWeb.ConnCase
  import :meck, except: [delete: 3]
  alias Verk.QueueStats
  alias Verk

  @stats [%{ queue: "default", running_counter: 1,
             finished_counter: 1, failed_counter: 0, status: :running }]

  setup do
    new QueueStats
    new Verk
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

  describe "POST /pause" do
    test "pauses queue", %{conn: conn} do
      queue = "default"
      expect(Verk, :pause_queue, [:default], :ok)
      conn = post conn, "/queues/#{queue}/pause"
      assert redirected_to(conn) =~ "/queues"
      validate(Verk)
    end
  end

  describe "POST /resume" do
    test "resumes queue", %{conn: conn} do
      queue = "default"
      expect(Verk, :resume_queue, [:default], :ok)
      conn = post conn, "/queues/#{queue}/resume"
      assert redirected_to(conn) =~ "/queues"
      validate(Verk)
    end
  end
end
