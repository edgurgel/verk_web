defmodule VerkWeb.RetrySetPaginatorTest do
  use ExUnit.Case
  alias VerkWeb.RetrySetPaginator

  test 'with default params' do
    paginator = RetrySetPaginator.new(21)
    assert paginator == %RetrySetPaginator{ page: 1, per_page: 20, from: 0, to: 19, has_next: true, has_prev: false }
  end

  test 'second page' do
    paginator = RetrySetPaginator.new(2, 2)
    assert paginator == %RetrySetPaginator{ page: 2, per_page: 20, from: 20, to: 39, has_next: false, has_prev: true }
  end

  test 'passing page as string' do
    paginator = RetrySetPaginator.new(2, "2")
    assert paginator == %RetrySetPaginator{ page: 2, per_page: 20, from: 20, to: 39, has_next: false, has_prev: true }
  end

  test 'custom per page' do
    paginator = RetrySetPaginator.new(2, "1", "1")
    assert paginator == %RetrySetPaginator{ page: 1, per_page: 1, from: 0, to: 0, has_next: true, has_prev: false }

    paginator = RetrySetPaginator.new(2, "2", "1")
    assert paginator == %RetrySetPaginator{ page: 2, per_page: 1, from: 1, to: 1, has_next: false, has_prev: true }

    paginator = RetrySetPaginator.new(3, "3", "1")
    assert paginator == %RetrySetPaginator{ page: 3, per_page: 1, from: 2, to: 2, has_next: false, has_prev: true }

    paginator = RetrySetPaginator.new(210, "2", "10")
    assert paginator == %RetrySetPaginator{ page: 2, per_page: 10, from: 10, to: 19, has_next: true, has_prev: true }
  end
end

