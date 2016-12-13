defmodule VerkWeb.DeadControllerTest do
  use VerkWeb.ConnCase

  setup do
    on_exit fn -> :meck.unload end
    :ok
  end

  test "DELETE / jobs delete expecific jobs", %{conn: conn} do
    fake_job_json = "{\"jid\": \"123\"}"
    :meck.expect(Verk.DeadSet, :delete_job, [fake_job_json], :ok)
    delete conn, "/dead", jobs_to_delete: [fake_job_json]
  end

  test "DELETE / passing no jobs deletes all jobs", %{conn: conn} do
    :meck.expect(Verk.DeadSet, :clear, 0, :ok)
    delete conn, "/dead"
  end
end
