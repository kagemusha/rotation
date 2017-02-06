defmodule Rotation.Factory do
  alias Rotation.Repo

  def build(:player) do
    %Rotation.Player{name: "Bill"}
  end

  def build(:pair) do
    %Rotation.Pair{}
  end

  def build(:pairing) do
    %Rotation.Pairing{}
  end


  def build(factory_name, attributes) do
    factory_name |> build() |> struct(attributes)
  end

  def insert!(factory_name, attributes) do
    Repo.insert! build(factory_name, attributes)
  end

end