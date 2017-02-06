defmodule Rotation.Player do
  use Rotation.Web, :model
  alias Rotation.Repo

  schema "players" do
    field :name, :string
    field :active, :boolean, default: false

    timestamps()
  end

  def active do
    Repo.all(from p in "players", where: p.active == true, select: [:id, :name, :active])
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :active])
    |> validate_required([:name, :active])
  end
end
