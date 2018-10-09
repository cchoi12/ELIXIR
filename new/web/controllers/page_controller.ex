defmodule New.PageController do
  use New.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
