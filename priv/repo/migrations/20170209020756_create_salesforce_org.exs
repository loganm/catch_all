defmodule CatchAll.Repo.Migrations.CreateSalesforceOrg do
  use Ecto.Migration

  def change do
    create table(:salesforce_orgs) do
      add :name, :string
      add :org_id, :string

      timestamps()
    end

  end
end
