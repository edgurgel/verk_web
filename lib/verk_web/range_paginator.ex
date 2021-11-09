defmodule VerkWeb.RangePaginator do
  @moduledoc """
  Range paginator for the pages.
  """

  defstruct [:page, :per_page, :from, :to, :has_next, :has_prev]

  def new(total_entries, page \\ 1, per_page \\ 20) do
    page = to_int(page, 1)
    per_page = to_int(per_page, 20)

    from = if page > 1, do: (page - 1) * per_page, else: 0
    to = if page > 1, do: from + per_page - 1, else: per_page - 1
    has_next = total_entries - 1 > to
    has_prev = page > 1

    %VerkWeb.RangePaginator{
      page: page,
      per_page: per_page,
      from: from,
      to: to,
      has_next: has_next,
      has_prev: has_prev
    }
  end

  defp to_int(nil, default), do: default
  defp to_int(page, _) when is_integer(page), do: page
  defp to_int(page, _), do: page |> Integer.parse() |> elem(0)
end
