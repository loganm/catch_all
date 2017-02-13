defmodule CatchAll.Repo.Migrations.AddFieldsToEmails do
  use Ecto.Migration

  def change do
    alter table(:emails) do
      add :return_path, :string
      add :date, :string
      add :subject, :string
      add :message_id, :string
      add :mime_version, :string
      add :content_type, :string
      add :content_transfer_encoding, :string
      add :x_sfdc_lk, :string
      add :x_sfdc_user, :string
      add :x_sender, :string
      add :x_mail_abuse_inquiries, :string
      add :x_sfdc_orgtype, :string
      add :x_sfdcorgrelay, :string
      add :x_sfdcrelayaddr, :string
      add :x_sfdcrelayport, :string
      add :x_sfdctls, :string
      add :x_sfdc_binding, :string
      add :x_sfdc_emailcategory, :string
      add :x_sfdc_entityid, :string
      add :x_sfdc_interface, :string
    end
  end
end
