defmodule CatchAll.MailController do
  use CatchAll.Web, :controller
  alias CatchAll.SalesforceOrg
  alias CatchAll.Email

  def index(conn, %{"salesforce_org_id" => salesforce_org_id}) do
    salesforce_org = Repo.get(SalesforceOrg, salesforce_org_id)
    emails = Repo.all(from e in Email, where: e.salesforce_org_id == ^salesforce_org.id)
    render conn, "index.html", emails: emails
  end
  
  def show(conn, %{"salesforce_org_id" => salesforce_org_id, "email_id" => email_id}) do
    salesforce_org = Repo.get(SalesforceOrg, salesforce_org_id)
    email = Repo.get(Email, email_id)
    render conn, "index.html", salesforce_org: salesforce_org, email: email
  end

  def orphans(conn, _params) do
    emails = Repo.all(from e in Email, where: is_nil(e.salesforce_org_id))
    render conn, "index.html", emails: emails
  end
end
