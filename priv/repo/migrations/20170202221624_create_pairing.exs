defmodule Rotation.Repo.Migrations.CreatePairing do
  use Ecto.Migration

  def change do
    create table(:pairings) do
      add :pair_id, references(:pairs, on_delete: :nothing)
      add :period, :date
      add :completed, :boolean, default: false, null: false
      add :prs, :text
      add :comments, :text

      timestamps()
    end

  end
end
