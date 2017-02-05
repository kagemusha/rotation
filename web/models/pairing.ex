defmodule Rotation.Pairing do
  use Rotation.Web, :model

  schema "pairings" do
    field :period, :date
    field :completed, :boolean, default: false
    field :pull_requests, :string
    field :comments, :string

    timestamps()
  end

  def generate_pairings(date, preset_pairings=[]) do

  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:period, :completed, :pull_requests, :comments])
    |> validate_required([:period])
  end
end
