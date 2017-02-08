defmodule MailtrapClone.PageController do
  use MailtrapClone.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
