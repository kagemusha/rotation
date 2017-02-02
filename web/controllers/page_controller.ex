defmodule Rotation.PageController do
  use Rotation.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
