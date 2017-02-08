defmodule CatchAll.MailController do
  use CatchAll.Web, :controller
  alias CatchAll.Email 

  def index(conn, _params) do
    emails = Repo.all(Email)
    render conn, "index.html", emails: emails
  end
end
