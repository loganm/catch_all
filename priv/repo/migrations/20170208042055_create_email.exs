defmodule CatchAll.Repo.Migrations.CreateEmail do
  use Ecto.Migration

  def change do
    create table(:emails) do
      add :to, :string
      add :from, :string
      add :data, :text

      timestamps()
    end

  end
end
