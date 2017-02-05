defmodule Rotation.PairingTest do
  use Rotation.ModelCase

  alias Rotation.Pairing

  @valid_attrs %{comments: "some content", completed: true, pull_requests: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Pairing.changeset(%Pairing{}, @valid_attrs)
    assert changeset.valid?
  end

  test "generate pairings" do
    changeset = Pairing.changeset(%Pairing{}, @invalid_attrs)
    refute changeset.valid?
  end
end
