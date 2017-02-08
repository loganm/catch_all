defmodule MailtrapClone.MailController do
  use MailtrapClone.Web, :controller
  alias MailtrapClone.Email 

  def index(conn, _params) do
    emails = Repo.all(Email)
    render conn, "index.html", emails: emails
  end
end
