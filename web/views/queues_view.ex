defmodule VerkWeb.QueuesView do
  use VerkWeb.Web, :view

  def enqueued_jobs(jobs) do
    Enum.map jobs, fn job ->
      %{
        jid: job.jid,
        class: job.class,
        args: job.args |> inspect,
        job: job
      }
    end
  end

  def jobs(running_jobs) do
    Enum.map running_jobs, fn running_job ->
      job = running_job.job
      %{
        jid: job.jid,
        started_at: running_job.started_at |> Timex.DateFormat.format!("{ISO}"),
        class: job.class,
        args: job.args |> inspect,
        job: job
      }
    end
  end
end
