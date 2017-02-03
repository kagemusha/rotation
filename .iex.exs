import Ecto.Queryable
import Ecto.Query, only: [from: 1, from: 2]
alias Rotation.Repo
alias Rotation.Player
alias Rotation.Pair
alias Rotation.Pairing

defmodule R do
  def reload! do
    Mix.Task.reenable "compile.elixir"
    Application.stop(Mix.Project.config[:app])
    Mix.Task.run "compile.elixir"
    Application.start(Mix.Project.config[:app], :permanent)
  end
end

