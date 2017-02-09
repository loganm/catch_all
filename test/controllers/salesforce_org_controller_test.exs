defmodule CatchAll.SalesforceOrgControllerTest do
  use CatchAll.ConnCase

  alias CatchAll.SalesforceOrg
  @valid_attrs %{name: "some content", org_id: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, salesforce_org_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing salesforce orgs"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, salesforce_org_path(conn, :new)
    assert html_response(conn, 200) =~ "New salesforce org"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, salesforce_org_path(conn, :create), salesforce_org: @valid_attrs
    assert redirected_to(conn) == salesforce_org_path(conn, :index)
    assert Repo.get_by(SalesforceOrg, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, salesforce_org_path(conn, :create), salesforce_org: @invalid_attrs
    assert html_response(conn, 200) =~ "New salesforce org"
  end

  test "shows chosen resource", %{conn: conn} do
    salesforce_org = Repo.insert! %SalesforceOrg{}
    conn = get conn, salesforce_org_path(conn, :show, salesforce_org)
    assert html_response(conn, 200) =~ "Show salesforce org"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, salesforce_org_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    salesforce_org = Repo.insert! %SalesforceOrg{}
    conn = get conn, salesforce_org_path(conn, :edit, salesforce_org)
    assert html_response(conn, 200) =~ "Edit salesforce org"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    salesforce_org = Repo.insert! %SalesforceOrg{}
    conn = put conn, salesforce_org_path(conn, :update, salesforce_org), salesforce_org: @valid_attrs
    assert redirected_to(conn) == salesforce_org_path(conn, :show, salesforce_org)
    assert Repo.get_by(SalesforceOrg, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    salesforce_org = Repo.insert! %SalesforceOrg{}
    conn = put conn, salesforce_org_path(conn, :update, salesforce_org), salesforce_org: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit salesforce org"
  end

  test "deletes chosen resource", %{conn: conn} do
    salesforce_org = Repo.insert! %SalesforceOrg{}
    conn = delete conn, salesforce_org_path(conn, :delete, salesforce_org)
    assert redirected_to(conn) == salesforce_org_path(conn, :index)
    refute Repo.get(SalesforceOrg, salesforce_org.id)
  end
end
