defmodule VerkWeb.RetriesControllerTest do
  use VerkWeb.ConnCase
  alias Verk.RetrySet
  import :meck, except: [delete: 3]

  setup do
    new RetrySet
    on_exit fn -> unload() end
    :ok
  end

  test "POST / action delete jobs delete specific jobs", %{conn: conn} do
    fake_job_json = "{\"jid\": \"123\"}"
    expect(RetrySet, :delete_job!, [fake_job_json], :ok)
    post conn, "/retries", [jobs_to_modify: [fake_job_json], action: "delete"]
    assert validate RetrySet
  end

  test "POST / action retry jobs retries specific jobs", %{conn: conn} do
    fake_job_json = "{\"jid\": \"123\"}"
    expect(RetrySet, :requeue_job!, [fake_job_json], :ok)
    post conn, "/retries", [jobs_to_modify: [fake_job_json], action: "requeue"]
    assert validate RetrySet
  end

  test "DELETE / passing no jobs deletes all jobs", %{conn: conn} do
    expect(RetrySet, :clear!, 0, :ok)
    delete conn, "/retries"
    assert validate RetrySet
  end
end
