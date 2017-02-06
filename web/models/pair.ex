defmodule Rotation.Pair do
  import Ecto.Query
  use Rotation.Web, :model
  alias Rotation.Repo
  alias Rotation.Player
  alias Rotation.Pair

  schema "pairs" do
    belongs_to :player1, Player
    belongs_to :player2, Player
    field :key, :string
    field :active, :boolean, default: false
    field :last_pairing, Ecto.Date

    timestamps()
  end

  def active do
    existing_active_pairs = Repo.all where(Pair, active: true)
    prospective_pairs = prospective_active_pairs(Player.active)
    Enum.map(prospective_pairs, fn(pair) ->
      [key, p1, p2] = pair
      Enum.find(existing_active_pairs, &(&1.key == key)) || Pair.create!(p1, p2)
    end)
  end

  def prospective_active_pairs(active_players) do
    combos active_players, [], length(active_players)
  end

  defp combos(players, combo_list, _) when length(players) == 1 do
    combo_list
  end

  defp combos(players, combo_list, total_player_count) do
    [current_player | remaining_players] = players
    new_combos = Enum.map remaining_players, &([pair_key(current_player, &1), current_player, &1])
    combos remaining_players, combo_list ++ new_combos, total_player_count
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:active, :last_pairing])
    |> validate_required([:active, :last_pairing])
  end

  def pair_key(player1, player2) do
    "#{player1.id}-#{player2.id}"
  end

  def players(pair) do
    [pair.player1, pair.player2]
  end

  def create!(player1, player2, active \\ true) do
    key = pair_key(player1, player2)
    Repo.insert! %Pair{player1_id: player1.id, player2_id: player2.id, key: key, active: active}
  end
end
