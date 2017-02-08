defmodule CatchAll.PageController do
  use CatchAll.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
