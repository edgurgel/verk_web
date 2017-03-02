defmodule VerkWeb.SharedViewTest do
  use VerkWeb.ConnCase, async: true
  alias VerkWeb.SharedView

  describe "enqueued_at/1" do
    test "with nil" do
      assert SharedView.enqueued_at(nil) == "N/A"
    end

    test "with enqueued_at as integer" do
      assert SharedView.enqueued_at(0) =~ ~r/.* years ago/
    end

    test "with enqueued_at as float" do
      assert SharedView.enqueued_at(1.5) =~ ~r/.* years ago/
    end
  end
end
