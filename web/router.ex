defmodule CatchAll.Router do
  use CatchAll.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CatchAll do
    pipe_through :browser # Use the default browser stack

    resources "/orgs", SalesforceOrgController

    get "/orgs/:salesforce_org_id/emails", MailController, :index
    get "/emails/:email_id", MailController, :show
    get "/orphan_emails", MailController, :orphans

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", CatchAll do
  #   pipe_through :api
  # end
end
