defmodule CatchAll.SalesforceOrgController do
  use CatchAll.Web, :controller

  alias CatchAll.SalesforceOrg

  def index(conn, _params) do
    salesforce_orgs = Repo.all(SalesforceOrg)
    render(conn, "index.html", salesforce_orgs: salesforce_orgs)
  end

  def new(conn, _params) do
    changeset = SalesforceOrg.changeset(%SalesforceOrg{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"salesforce_org" => salesforce_org_params}) do
    changeset = SalesforceOrg.changeset(%SalesforceOrg{}, salesforce_org_params)

    case Repo.insert(changeset) do
      {:ok, _salesforce_org} ->
        conn
        |> put_flash(:info, "Salesforce org created successfully.")
        |> redirect(to: salesforce_org_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    salesforce_org = Repo.get!(SalesforceOrg, id)
    render(conn, "show.html", salesforce_org: salesforce_org)
  end

  def edit(conn, %{"id" => id}) do
    salesforce_org = Repo.get!(SalesforceOrg, id)
    changeset = SalesforceOrg.changeset(salesforce_org)
    render(conn, "edit.html", salesforce_org: salesforce_org, changeset: changeset)
  end

  def update(conn, %{"id" => id, "salesforce_org" => salesforce_org_params}) do
    salesforce_org = Repo.get!(SalesforceOrg, id)
    changeset = SalesforceOrg.changeset(salesforce_org, salesforce_org_params)

    case Repo.update(changeset) do
      {:ok, salesforce_org} ->
        conn
        |> put_flash(:info, "Salesforce org updated successfully.")
        |> redirect(to: salesforce_org_path(conn, :show, salesforce_org))
      {:error, changeset} ->
        render(conn, "edit.html", salesforce_org: salesforce_org, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    salesforce_org = Repo.get!(SalesforceOrg, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(salesforce_org)

    conn
    |> put_flash(:info, "Salesforce org deleted successfully.")
    |> redirect(to: salesforce_org_path(conn, :index))
  end
end
