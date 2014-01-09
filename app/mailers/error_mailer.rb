# encoding: utf-8
class ErrorMailer < ActionMailer::Base

  def an_error_was_found(url, exception_message, exception_backtrace, ip, env)
    @recipients  = "cesar@letwrong.com"
    @subject     = "Manuable URGENTE: Sucedió un error en #{url} (#{Time.now})"
    @url = url

    @exception_message = exception_message
    @exception_backtrace = exception_backtrace
    @ip = ip
    @env = env
    mail(to: @recipients, subject: @subject, from: %("Manuable" <cesar@letwrong.com>), content_type: "text/html")
  end

end
