defmodule Rotation.PairTest do
  use Rotation.ModelCase
  import Rotation.Factory

  alias Rotation.Pair

  @valid_attrs %{active: true, last_pairing: %{day: 17, month: 4, year: 2010}}
  @invalid_attrs %{}

  test "create new player" do
    [p1, p2] = Enum.map([1,2], &(insert!(:player, %{name: "p#{&1}", active: true})))
    pair = Pair.create!(p1, p2)
    assert pair.key == "#{p1.id}-#{p2.id}"
    assert pair.active == true
  end

  test "prospective_active_pairs" do
    [p1, p2, p3] = Enum.map([1,2, 3], &(insert!(:player, %{name: "p#{&1}", active: true})))
    pair_keys = Pair.prospective_active_pairs([p1, p2, p3])
    assert pair_keys == [
          ["#{p1.id}-#{p2.id}", p1, p2],
          ["#{p1.id}-#{p3.id}", p1, p3],
          ["#{p2.id}-#{p3.id}", p2, p3]
        ];
  end

  test "active_pairs" do
    [p1, p2] = Enum.map([1,2], &(insert!(:player, %{name: "p#{&1}", active: true})))
    insert!(:player, %{name: "p3", active: true})
    Pair.create! p1, p2
    [pair1, _, _] = Pair.active
    pair1 = Repo.preload(pair1, [:player1, :player2])
    assert [p1, p2] == [pair1.player1, pair1.player2]
  end

  test "changeset with valid attributes" do
    changeset = Pair.changeset(%Pair{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Pair.changeset(%Pair{}, @invalid_attrs)
    refute changeset.valid?
  end
end
