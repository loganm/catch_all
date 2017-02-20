defmodule CatchAll.Repo.Migrations.AddBodyToEmails do
  use Ecto.Migration

  def change do
    alter table(:emails) do
      add :body, :string
    end
  end
end
