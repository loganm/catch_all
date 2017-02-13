defmodule Mail.Receive do
  require Logger
  require MimeMail
  alias CatchAll.Repo
  alias CatchAll.Email

  def receive_message(_from, _to, data) do
    try do

      email = MimeMail.from_string(data)

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
        "x_sfdc_interface": get_header(email, :"x-sfdc-interface")
      }

      changeset = Email.changeset(%Email{}, record)

      case Repo.insert(changeset) do
        {:ok, email} ->
          Logger.info("email inserted #{inspect(email)}")
        {:error, changeset} ->
          Logger.warn("failed email insert #{inspect(changeset)}")
        _ ->
          Logger.warn("wat")
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
