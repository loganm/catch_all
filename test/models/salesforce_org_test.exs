defmodule CatchAll.SalesforceOrgTest do
  use CatchAll.ModelCase

  alias CatchAll.SalesforceOrg

  @valid_attrs %{name: "some content", org_id: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = SalesforceOrg.changeset(%SalesforceOrg{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = SalesforceOrg.changeset(%SalesforceOrg{}, @invalid_attrs)
    refute changeset.valid?
  end
end
