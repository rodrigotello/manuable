class UserMailer < ActionMailer::Base
  default from: "claudio@manuable.com"

  def welcome_email user
    @user = user
  end
end
