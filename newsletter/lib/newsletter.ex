defmodule Newsletter do
  def read_emails(path), do: File.read!(path) |> String.split()

  def open_log(path), do: File.open!(path, [:write])

  def log_sent_email(pid, email), do: IO.write(pid, "#{email}\n")

  def close_log(pid), do: File.close(pid)

  def send_newsletter(emails_path, log_path, send_fun) do
    logf = open_log(log_path)

    read_emails(emails_path)
    |> Enum.each(fn email_addr ->
      if send_fun.(email_addr) == :ok do
        log_sent_email(logf, email_addr)
      end
    end)

    close_log(logf)
  end
end
