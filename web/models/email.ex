defmodule CatchAll.Email do
  use CatchAll.Web, :model

  schema "emails" do
    field :to, :string
    field :from, :string
    field :data, :string
    field :return_path, :string
    field :date, :string
    field :subject, :string
    field :message_id, :string
    field :mime_version, :string
    field :content_type, :string
    field :content_transfer_encoding, :string
    field :x_sfdc_lk, :string
    field :x_sfdc_user, :string
    field :x_sender, :string
    field :x_mail_abuse_inquiries, :string
    field :x_sfdc_orgtype, :string
    field :x_sfdcorgrelay, :string
    field :x_sfdcrelayaddr, :string
    field :x_sfdcrelayport, :string
    field :x_sfdctls, :string
    field :x_sfdc_binding, :string
    field :x_sfdc_emailcategory, :string
    field :x_sfdc_entityid, :string
    field :x_sfdc_interface, :string
    embeds_many :headers, Header
    belongs_to :salesforce_org, CatchAll.SalesforceOrg

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:to, :from, :data, :return_path, :date, :from, :to, :subject, :message_id, :mime_version, :content_type, :content_transfer_encoding, :x_sfdc_lk, :x_sfdc_user, :x_sender, :x_mail_abuse_inquiries, :x_sfdc_orgtype, :x_sfdcorgrelay, :x_sfdcrelayaddr, :x_sfdcrelayport, :x_sfdctls, :x_sfdc_binding, :x_sfdc_emailcategory, :x_sfdc_entityid, :x_sfdc_interface, :salesforce_org_id])
    |> cast_assoc(:salesforce_org, required: false)
    |> validate_required([:to, :from, :data])
  end
end
