defmodule VerkWeb.DeadView do
  use VerkWeb.Web, :view

  def jobs(dead_jobs) do
    Enum.map(dead_jobs, fn dead_job ->
      %{
        jid: dead_job.jid,
        retry_count: dead_job.retry_count,
        class: dead_job.class,
        args: dead_job.args |> inspect,
        original_json: dead_job.original_json,
        job: dead_job
      }
    end)
  end
end
