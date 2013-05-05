class UserMailer < ActionMailer::Base
  default from: "claudio@manuable.com"

  def welcome_email user
    @user = user
    mail(:to => user.email, subject: 'Bienvenido a Manuable')
  end
end
