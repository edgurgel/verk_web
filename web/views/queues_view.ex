defmodule VerkWeb.QueuesView do
  use VerkWeb.Web, :view

  def jobs(running_jobs) do
    Enum.map running_jobs, fn running_job ->
      job = running_job.job
      %{
        jid: job.jid,
        enqueued_at: job.enqueued_at |> Timex.Date.from(:secs) |> Timex.DateFormat.format!("{ISO}"),
        started_at: running_job.started_at |> Timex.DateFormat.format!("{ISO}"),
        class: job.class,
        args: job.args |> inspect
      }
    end
  end
end
