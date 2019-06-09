defmodule VerkWeb.QueueRangePaginator do
  defstruct [:from, :to, :has_next, :has_prev, :per_page]

  def new(entries, from \\ "0-0", per_page \\ 25) do
    to = to(entries)

    has_next = if length(entries) == per_page, do: true, else: false
    has_prev = if from != "0-0", do: true, else: false

    %VerkWeb.RangePaginator{
      from: from,
      to: to,
      has_next: has_next,
      has_prev: has_prev,
      per_page: per_page
    }|> IO.inspect
  end

  defp to([]), do: nil
  defp to(entries) do
    job = entries |> List.last
    job.item_id
  end
end
