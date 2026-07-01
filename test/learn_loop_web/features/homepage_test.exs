defmodule LearnLoopWeb.HomepageTest do
  use LearnLoopWeb.ConnCase

  test "visits the homepage with PhoenixTest", %{conn: conn} do
    conn
    |> visit(~p"/")
    |> assert_has("h1", text: "Phoenix Framework")
    |> assert_has("p", text: "Peace of mind from prototype to production.")
  end
end
