defmodule LearnLoopWeb.PageController do
  use LearnLoopWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
