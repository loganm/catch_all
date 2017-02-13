defmodule Mail.Receive do
  require Logger
  require MimeMail
  alias CatchAll.Repo
  alias CatchAll.Email
  import Ecto.Query

  def receive_message(_from, _to, data, state) do
    try do

      email = MimeMail.from_string(data)

      x_sfdc_lk = get_header(email, :"x-sfdc-lk")
      search_param = "#{x_sfdc_lk}"
      org_query = from o in CatchAll.SalesforceOrg, where: o.org_id == ^search_param
      salesforce_orgs = CatchAll.Repo.all(org_query)

      if length(salesforce_orgs) == 1 do
        record = %{
          "data": data,
          "return_path": get_header(email, :"return-path"),
          "date": get_header(email, :date),
          "from": get_header(email, :from),
          "to": get_header(email, :to),
          "subject": get_header(email, :subject),
          "message_id": get_header(email, :"message-id"),
          "mime_version": get_header(email, :"mime-version"),
          "content_type": get_header(email, :"content-type"),
          "content_transfer_encoding": get_header(email, :"content-transfer-encoding"),
          "x_sfdc_lk": get_header(email, :"x-sfdc-lk"),
          "x_sfdc_user": get_header(email, :"x-sfdc-user"),
          "x_sender": get_header(email, :"x-sender"),
          "x_mail_abuse_inquiries": get_header(email, :"x-mail_abuse_inquiries"),
          "x_sfdc_orgtype": get_header(email, :"x-sfdc-orgtype"),
          "x_sfdcorgrelay": get_header(email, :"x-sfdcorgrelay"),
          "x_sfdcrelayaddr": get_header(email, :"x-sfdcrelayaddr"),
          "x_sfdcrelayport": get_header(email, :"x-sfdcrelayport"),
          "x_sfdctls": get_header(email, :"x-sfdctls"),
          "x_sfdc_binding": get_header(email, :"x-sfdc-binding"),
          "x_sfdc_emailcategory": get_header(email, :"x-sfdc-emailcategory"),
          "x_sfdc_entityid": get_header(email, :"x-sfdc-entityid"),
          "x_sfdc_interface": get_header(email, :"x-sfdc-interface"),
          "salesforce_org_id": Enum.at(salesforce_orgs, 0).id
        }

        changeset = Email.changeset(%Email{}, record)

        case Repo.insert(changeset) do
          {:ok, email} ->
            Logger.info("email inserted #{inspect(email)}")
            {:ok, UUID.uuid5(:dns, "trineo.com", :default), state}
          {:error, changeset} ->
            Logger.warn("failed email insert #{inspect(changeset)}")
            {:error, "internal systems error"}
        end
      else
        {:error, "sf org not recognized"}
      end
    catch
      e -> Logger.warn(inspect(e))
    end
  end

  def get_header(email, atom) do
    case email.headers[atom] do
      {:raw, value} ->
          Enum.at(String.split(value, ": ", parts: 2), 1)
      _ ->
          nil
    end
  end
end
