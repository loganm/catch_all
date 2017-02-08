defmodule CatchAll.Email do
  use CatchAll.Web, :model

  schema "emails" do
    field :to, :string
    field :from, :string
    field :data, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:to, :from, :data])
    |> validate_required([:to, :from, :data])
  end
end
