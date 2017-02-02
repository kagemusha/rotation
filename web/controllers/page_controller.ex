defmodule Rotation.PageController do
  use Rotation.Web, :controller

  def index(conn, _params) do
    players = Repo.all(Rotation.Player)
    render conn, "index.html", players: players
  end
end
