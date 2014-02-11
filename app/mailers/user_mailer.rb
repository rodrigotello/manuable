# encoding: utf-8
class UserMailer < ActionMailer::Base
  default from: "claudio@manuable.com", content_type: "text/html"
  layout 'user_mailer'

  def welcome_email user
    @user = user
    mail(:to => user.email, subject: 'Bienvenido a Manuable')
  end

  def like by, product, owner
    @by = by
    @product = product
    @owner = owner

    mail to: owner.email, subject: "Manuable - Le gustó!"
  end
end
