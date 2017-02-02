defmodule Rotation.Repo do
  use Ecto.Repo, otp_app: :rotation
  use Scrivener, page_size: 10
end
