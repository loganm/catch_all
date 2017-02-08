defmodule Mail.Receive do
  require Logger

  def receive_message(from, to, data) do
    try do
        Logger.info("Email: Received email, black hole")
        Logger.info("To: #{to}")
        Logger.info("From: #{from}")
        Logger.info("Data: #{data}")
    catch
      e -> Logger.warn(inspect(e))
    end
  end
end
