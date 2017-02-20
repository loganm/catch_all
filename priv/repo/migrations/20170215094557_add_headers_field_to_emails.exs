defmodule CatchAll.Repo.Migrations.AddHeadersFieldToEmails do
  use Ecto.Migration

  def change do
    alter table(:emails) do
      add :headers, {:array, :map}, default: []
    end
  end
end
