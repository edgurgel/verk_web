defmodule VerkWeb.RetriesControllerTest do
  use VerkWeb.ConnCase

  setup do
    on_exit fn -> :meck.unload end
    :ok
  end

  test "DELETE / jobs delete expecific jobs", %{conn: conn} do
    fake_job_json = "{\"jid\": \"123\"}"
    :meck.expect(Verk.RetrySet, :delete_job, [fake_job_json], :ok)
    delete conn, "/retries", jobs_to_delete: [fake_job_json]
  end

  test "DELETE / passing no jobs deletes all jobs" do
    :meck.expect(Verk.RetrySet, :clear, [], :ok)
    delete conn, "/retries"
  end
end
