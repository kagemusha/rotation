defmodule Rotation.Pair do
  use Rotation.Web, :model
  alias Rotation.Player

  schema "pairs" do
    belongs_to :player1, Player
    belongs_to :player2, Player
    field :key, :string
    field :active, :boolean, default: false
    field :last_pairing, Ecto.Date

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:active, :last_pairing])
    |> validate_required([:active, :last_pairing])
  end
end
