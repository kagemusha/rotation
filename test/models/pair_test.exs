defmodule Rotation.PairTest do
  use Rotation.ModelCase

  alias Rotation.Pair

  @valid_attrs %{active: true, last_pairing: %{day: 17, month: 4, year: 2010}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Pair.changeset(%Pair{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Pair.changeset(%Pair{}, @invalid_attrs)
    refute changeset.valid?
  end
end
