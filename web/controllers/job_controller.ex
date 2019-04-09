defmodule VerkWeb.JobController do
  use VerkWeb.Web, :controller

  def show(conn, %{"queue" => queue, "job_id" => job_id}) do
    case Verk.WorkersManager.inspect_worker(queue, job_id) do
      {:ok, %{info: info, job: job, process: process, started_at: started_at}} ->
        render(conn, "show.html",
          queue: queue,
          job_id: job_id,
          job: job,
          info: info,
          started_at: started_at,
          process: inspect(process)
        )

      {:error, _} ->
        conn
        |> put_status(:not_found)
        |> render(VerkWeb.ErrorView, "404.html")
    end
  end
end
