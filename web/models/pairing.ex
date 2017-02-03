defmodule Rotation.Pairing do
  use Rotation.Web, :model

  schema "pairings" do
    field :completed, :boolean, default: false
    field :prs, :string
    field :comments, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:key, :completed, :prs, :comments])
    |> validate_required([:key, :completed, :prs, :comments])
  end
end
