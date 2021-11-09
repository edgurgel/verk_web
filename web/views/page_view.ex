defmodule VerkWeb.PageView do
  use VerkWeb.Web, :view

  def total_processed do
    Verk.Stats.total().processed
  end

  def total_failed do
    Verk.Stats.total().failed
  end

  def retries_count do
    Verk.RetrySet.count!()
  end

  def dead_count do
    Verk.DeadSet.count!()
  end

  def uptime do
    {time, _} = :erlang.statistics(:wall_clock)
    time |> Timex.Duration.from_milliseconds() |> Timex.format_duration(:humanized)
  end

  def process_count, do: :erlang.system_info(:process_count)
  def process_limit, do: :erlang.system_info(:process_limit)
end
