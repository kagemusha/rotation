# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rotation.Repo.insert!(%Rotation.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
IO.puts "db seeding!"

import Ecto.Query, only: [from: 1]
alias Rotation.Repo
alias Rotation.Player
alias Rotation.Pair
alias Rotation.Pairing

Enum.each([Player, Pair, Pairing], &((from item in &1) |> Repo.delete_all))


active_players = ["Andrew P","Jeff L","Dennis S",
                  "Zach M","Hannah Jane B","Michael M"]

Enum.each(active_players, &(Repo.insert!(%Player{name: &1, active: true})))

[p1, p2 | _] = Repo.all Player
key = "#{p1.id}:#{p2.id}"
IO.puts key

pair = Repo.insert! %Pair{key: key, active: true, player1: p1, player2: p2}

#Repo.insert! %Pairing{pair: pair, period: ~D[2017-02-06]}