defmodule Mail.Receive do
  require Logger
  alias CatchAll.Repo
  alias CatchAll.Email

  def receive_message(from, to, data) do
    try do
      changeset = Email.changeset(%Email{}, %{
        "from": from,
        "to": inspect(to),
        "data": data
      })
      case Repo.insert(changeset) do
        {:ok, email} ->
          Logger.info("email inserted #{inspect(email)}")
        {:error, changeset} ->
          Logger.warn("failed email insert #{to} #{inspect(changeset)}")
        _ ->
          Logger.warn("wat")
      end
    catch
      e -> Logger.warn(inspect(e))
    end
  end
end
