defmodule Rotation.PairingTest do
  use Rotation.ModelCase
  import Rotation.Factory
  alias Rotation.Pairing
  alias Rotation.Player
  alias Rotation.Pair

  @valid_attrs %{period: DateTime.utc_now(), comments: "some content"}

  test "changeset with valid attributes" do
    changeset = Pairing.changeset(%Pairing{}, @valid_attrs)
    assert changeset.valid?
  end

  test "least recent pairs" do
    names = Enum.map 1..4, &("p#{&1}")
    Enum.each names, &(insert!(:player, %{name: &1, active: true}))
    [p1, p2, p3, _] = Player.active

    pair1 = Pair.create! p1, p2
    pair_date1 = ~D[2016-02-01]
    Repo.update Pair.changeset(pair1, %{last_pairing: pair_date1 })

    pair2 = Pair.create! p1, p3
    pair_date2 = ~D[2016-01-01]
    Repo.update Pair.changeset(pair2, %{last_pairing:  pair_date2 })

    #so sorted pairings should be p1-p4 p2-p3 p2-p4 p3-p4 p1-p3 p1-p2
    {never_paired_pairs, paired_pairs} = Enum.split(Pairing.least_recent_pairs, 4)
    Enum.each(never_paired_pairs, &(assert &1.last_pairing == nil))
    first_pair = Enum.at(never_paired_pairs, 0)
              |> Repo.preload([:player1, :player2])
    assert first_pair.player1.name == "p1"
    assert first_pair.player2.name == "p4"
    {:ok, epd1 } = Ecto.Date.cast(pair_date1)
    {:ok, epd2 } = Ecto.Date.cast(pair_date2)
    assert Enum.map(paired_pairs, &(&1.last_pairing)) == [epd2, epd1]

  end

  test "generate pairings" do
    names = Enum.map 1..6, &("a#{&1}")
    Enum.each names, &(insert!(:player, %{name: &1, active: true}))
    insert!(:player, %{name: "inactive1", active: false})
    [p1, p2, p3, p4, p5, p6] = Player.active
    pair1_2 = Pair.create! p1, p2
    Repo.update Pair.changeset(pair1_2, %{last_pairing: ~D[2016-02-01] })

    pairings = [pairing1, pairing2, pairing3] = Pairing.generate_pairings ~D[2016-03-01]
    pairing1 = Repo.preload pairing1, pair: [:player1, :player2]
    pairing2 = Repo.preload pairing2, pair: [:player1, :player2]
    pairing3 = Repo.preload pairing3, pair: [:player1, :player2]
    assert Pair.players(pairing1.pair) == Enum.map([p1, p3], &(Repo.get(Player, &1.id)))
    assert Pair.players(pairing2.pair) == Enum.map([p2, p4], &(Repo.get(Player, &1.id)))
    assert Pair.players(pairing3.pair) == Enum.map([p5, p6], &(Repo.get(Player, &1.id)))
  end

end
