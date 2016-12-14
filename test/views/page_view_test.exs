defmodule VerkWeb.PageViewTest do
  use VerkWeb.ConnCase, async: true
  alias VerkWeb.PageView

  describe "uptime/0" do
    test "uptime prints days hours minutes and seconds" do
      assert PageView.uptime =~ ~r/\d days, \d hours, \d minutes/
    end
  end
end
