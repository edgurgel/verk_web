defmodule VerkWeb.RangePaginatorTest do
  use ExUnit.Case
  alias VerkWeb.RangePaginator

  test 'with default params' do
    paginator = RangePaginator.new(21)
    assert paginator == %RangePaginator{ page: 1, per_page: 20, from: 0, to: 19, has_next: true, has_prev: false }
  end

  test 'second page' do
    paginator = RangePaginator.new(2, 2)
    assert paginator == %RangePaginator{ page: 2, per_page: 20, from: 20, to: 39, has_next: false, has_prev: true }
  end

  test 'passing page as string' do
    paginator = RangePaginator.new(2, "2")
    assert paginator == %RangePaginator{ page: 2, per_page: 20, from: 20, to: 39, has_next: false, has_prev: true }
  end

  test 'custom per page' do
    paginator = RangePaginator.new(2, "1", "1")
    assert paginator == %RangePaginator{ page: 1, per_page: 1, from: 0, to: 0, has_next: true, has_prev: false }

    paginator = RangePaginator.new(2, "2", "1")
    assert paginator == %RangePaginator{ page: 2, per_page: 1, from: 1, to: 1, has_next: false, has_prev: true }

    paginator = RangePaginator.new(3, "3", "1")
    assert paginator == %RangePaginator{ page: 3, per_page: 1, from: 2, to: 2, has_next: false, has_prev: true }

    paginator = RangePaginator.new(210, "2", "10")
    assert paginator == %RangePaginator{ page: 2, per_page: 10, from: 10, to: 19, has_next: true, has_prev: true }
  end
end

