defmodule VerkWeb.ScheduledControllerTest do
  use VerkWeb.ConnCase
  alias Verk.{SortedSet, Redis}
  import :meck, except: [delete: 3]

  setup do
    new SortedSet
    on_exit fn -> unload() end
    :ok
  end

  test "POST / jobs delete specific jobs", %{conn: conn} do
    fake_job_json = "{\"jid\": \"123\"}"
    expect(SortedSet, :delete_job!, ["schedule", fake_job_json, Redis], :ok)
    conn = post conn, "/scheduled", [jobs_to_modify: [fake_job_json], action: "delete"]
    assert validate SortedSet
    assert redirected_to(conn) == "/scheduled"
  end

  test "POST / action scheduled jobs retries specific jobs", %{conn: conn} do
    fake_job_json = "{\"jid\": \"123\"}"
    expect(SortedSet, :requeue_job!, ["schedule", fake_job_json, Redis], :ok)
    post conn, "/scheduled", [jobs_to_modify: [fake_job_json], action: "requeue"]
    assert validate SortedSet
  end

  test "DELETE / passing no jobs deletes all jobs", %{conn: conn} do
    expect(SortedSet, :clear!, ["schedule", Redis], :ok)
    conn = delete conn, "/scheduled"
    assert validate SortedSet
    assert redirected_to(conn) == "/scheduled"
  end
end
