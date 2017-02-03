defmodule Rotation.PairingTest do
  use Rotation.ModelCase

  alias Rotation.Pairing

  @valid_attrs %{comments: "some content", completed: true, key: "some content", prs: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Pairing.changeset(%Pairing{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Pairing.changeset(%Pairing{}, @invalid_attrs)
    refute changeset.valid?
  end
end
