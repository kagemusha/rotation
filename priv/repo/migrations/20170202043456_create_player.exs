defmodule Rotation.Repo.Migrations.CreatePlayer do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :name, :string
      add :active, :boolean, default: false, null: false

      timestamps()
    end

  end
end
