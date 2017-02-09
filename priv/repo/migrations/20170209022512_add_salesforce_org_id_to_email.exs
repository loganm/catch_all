defmodule CatchAll.Repo.Migrations.AddSalesforceOrgIdToEmail do
  use Ecto.Migration

  def change do
    alter table(:emails) do
      add :salesforce_org_id, :string
    end
  end
end
