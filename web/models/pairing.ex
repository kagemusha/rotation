defmodule Rotation.Pairing do
  use Rotation.Web, :model
  alias Rotation.Pairing
  alias Rotation.Pair
  alias Rotation.Player
  alias Rotation.Repo

  schema "pairings" do
    belongs_to :pair, Pair
    field :period, :date
    field :completed, :boolean, default: false
    field :pull_requests, :string
    field :comments, :string

    timestamps()
  end

#  def generate_pairings(date, preset_pairings \\ []) do
  def generate_pairings(date) do
    # sort by furthest pairing date
    available = map_list_attr(Player.active, :id, true)
    Enum.reduce least_recent_pairs(), available, fn(pair, available) ->
      pair = Repo.preload pair, [:player1, :player2]
      p1_id = pair.player1.id
      p2_id = pair.player2.id

      if Map.get(available, p1_id) && Map.get(available, p2_id) do
        Repo.insert! %Pairing{pair_id: pair.id, period: date, completed: false}
        %{available | p1_id => false, p2_id => false}
      else
        available
      end
    end
    Repo.all(Pairing)
  end

  def least_recent_pairs do
    Enum.sort(Pair.active, fn(pair1, pair2) ->
      date1 = pair1.last_pairing
      date2 = pair2.last_pairing
      cond do
        date1 == nil ->
          true
        date2 == nil ->
          false
        true ->
          Ecto.Date.compare(date1, date2) == :lt
      end
    end)
  end


  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:period, :completed, :pull_requests, :comments])
    |> validate_required([:period])
  end

  # useful util method - extract somewhere
  defp map_list_attr(list, attr, val) do
    Enum.reduce list, %{}, fn(map, acc) ->
      Map.put acc, Map.get(map, attr), val
    end
  end
end
