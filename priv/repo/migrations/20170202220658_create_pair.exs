defmodule Rotation.Repo.Migrations.CreatePair do
  use Ecto.Migration

  def change do
    create table(:pairs) do
      add :player1_id, references(:players, on_delete: :nothing)
      add :player2_id, references(:players, on_delete: :nothing)
      add :key, :string
      add :active, :boolean, default: false, null: false
      add :last_pairing, :date
      timestamps()
    end

  end
end
