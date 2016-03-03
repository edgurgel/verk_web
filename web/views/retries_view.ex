defmodule VerkWeb.RetriesView do
  use VerkWeb.Web, :view

  def jobs(failed_jobs) do
    Enum.map failed_jobs, fn failed_job ->
      %{
        jid: failed_job.jid,
        retry_count: failed_job.retry_count,
        class: failed_job.class,
        args: failed_job.args |> inspect,
        original_json: failed_job.original_json,
        job: failed_job
      }
    end
  end
end
