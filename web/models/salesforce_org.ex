defmodule CatchAll.SalesforceOrg do
  use CatchAll.Web, :model

  schema "salesforce_orgs" do
    field :name, :string
    field :org_id, :string
    has_many :emails, CatchAll.Email

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :org_id])
    |> validate_required([:name, :org_id])
  end
end
