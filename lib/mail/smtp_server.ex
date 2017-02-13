defmodule Mail.SMTPServer do
  require Logger
  @behaviour :gen_smtp_server_session

  def init(hostname, session_count, address, options) do
    Logger.info("Mail.SMTPServer.init -> hostname: #{inspect(hostname)}")
    Logger.info("Mail.SMTPServer.init -> session_count: #{inspect(session_count)}")
    Logger.info("Mail.SMTPServer.init -> address: #{inspect(address)}")
    Logger.info("Mail.SMTPServer.init -> options: #{inspect(options)}")
    if session_count > 40 do
      Logger.warn('SMTP server connection limit exceeded')
      {:stop, :normal, ['421 ', hostname, ' is too busy to accept mail right now']}
    else
      banner = [hostname, ' ESMTP']
      state = %{}
      {:ok, banner, state}
    end
  end

  # possibility of rejecting based on _from_ address
  def handle_MAIL(from, state) do
    Logger.info("Mail.SMTPServer.handle_MAIL -> from: #{inspect(from)}")
    Logger.info("Mail.SMTPServer.handle_MAIL -> state: #{inspect(state)}")
    {:ok, state}
  end

  def handle_MAIL_extension(extension, state) do
    Logger.info("Mail.SMTPServer.handle_MAIL_extension -> extension: #{inspect(extension)}")
    Logger.info("Mail.SMTPServer.handle_MAIL_extension -> state: #{inspect(state)}")
    {:ok, state}
  end

  # possibility of rejecting based on _to_ address
  def handle_RCPT(to, state) do
    Logger.info("Mail.SMTPServer.handle_RCPT -> to: #{inspect(to)}")
    Logger.info("Mail.SMTPServer.handle_RCPT -> state: #{inspect(state)}")
    {:ok, state}
  end

  def handle_RCPT_extension(extension, state) do
    Logger.info("Mail.SMTPServer.handle_RCPT_extension -> extension: #{inspect(extension)}")
    Logger.info("Mail.SMTPServer.handle_RCPT_extension -> state: #{inspect(state)}")
    {:ok, state}
  end

  # getting the actual mail. all the relevant stuff is in data.
  def handle_DATA(from, to, data, state) do
    Logger.info("Mail.SMTPServer.handle_DATA -> from: #{inspect(from)}")
    Logger.info("Mail.SMTPServer.handle_DATA -> to: #{inspect(to)}")
    Logger.info("Mail.SMTPServer.handle_DATA -> data: #{inspect(data)}")
    Logger.info("Mail.SMTPServer.handle_DATA -> state: #{inspect(state)}")
    Mail.Receive.receive_message(from, to, data, state)
  end

  # --------------------------------------------------------------------------------
  # less relevant stuff

  def handle_HELO(hostname, state) do
    Logger.info("Mail.SMTPServer.handle_HELO -> hostname: #{inspect(hostname)}")
    Logger.info("Mail.SMTPServer.handle_HELO -> state: #{inspect(state)}")
    {:ok, state}
  end

  def handle_EHLO(hostname, extensions, state) do
    Logger.info("Mail.SMTPServer.handle_EHLO -> hostname: #{inspect(hostname)}")
    Logger.info("Mail.SMTPServer.handle_EHLO -> extensions: #{inspect(extensions)}")
    Logger.info("handle_EHLO -> state: #{inspect(state)}")
    my_extensions = [ {'STARTTLS', true} | extensions ]
    {:ok, my_extensions, state}
  end

  def handle_RSET(state) do
    Logger.info("handle_RSET -> state: #{inspect(state)}")
    state
  end

  def handle_VRFY(address, state) do
    Logger.info("handle_VRFY -> address: #{inspect(address)}")
    Logger.info("handle_VRFY -> state: #{inspect(state)}")
    {:error, '252 VRFY disabled by policy, just send some mail', state}
  end

  def handle_other(verb, args, state) do
    Logger.info("handle_other -> verb: #{inspect(verb)}")
    Logger.info("handle_other -> args: #{inspect(args)}")
    Logger.info("handle_other -> state: #{inspect(state)}")
    {['500 Error: command not recognized : \'', verb, '\''], state}
  end

  def handle_STARTTLS(state) do
    Logger.info("handle_STARTTLS -> state: #{inspect(state)}")
    state
  end

  def handle_info(info, state) do
    Logger.info("handle_info -> info: #{inspect(info)}")
    Logger.info("handle_info -> state: #{inspect(state)}")
    {:noreply, state}
  end

  def code_change(old_vsn, state, extra) do
    Logger.info("code_change -> old_vsn: #{inspect(old_vsn)}")
    Logger.info("code_change -> state: #{inspect(state)}")
    Logger.info("code_change -> extra: #{inspect(extra)}")
    {:ok, state}
  end

  def terminate(reason, state) do
    Logger.info("terminate -> reason: #{inspect(reason)}")
    Logger.info("terminate -> state: #{inspect(state)}")
    {:ok, reason, state}
  end
end
