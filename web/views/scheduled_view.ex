defmodule VerkWeb.ScheduledView do
  use VerkWeb.Web, :view

  def scheduled_jobs(jobs) do
    Enum.map jobs, fn {job, perform_at} ->
      %{
        perform_at: Timex.from_unix(perform_at),
        queue: job.queue,
        jid: job.jid,
        class: job.class,
        args: job.args |> inspect,
        job: job
      }
    end
  end

  def perform_at(datetime) do
    Timex.format!(datetime, "{relative}", :relative)
  end
end
