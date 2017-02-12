defmodule CatchAll.Email do
  use CatchAll.Web, :model

  schema "emails" do
    field :to, :string
    field :from, :string
    field :data, :string
    belongs_to :salesforce_org, CatchAll.SalesforceOrg

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:to, :from, :data])
    |> cast_assoc(:salesforce_org, required: false)
    |> validate_required([:to, :from, :data])
  end
end
