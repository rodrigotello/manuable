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

  def new_event_request event_request, user
    @event_request = event_request
    @user = user
    @event = @event_request.event
    @petitioner = @event_request.user
    mail to: @user.email, subject: "Manuable - #{@event.name}: Solicitud de participación"
  end

  def event_request_accepted event_request
    @event_request = event_request
    @event = @event_request.event
    @petitioner = @event_request.user

    mail to: @petitioner.email, subject: "Manuable - Solicitud aceptada"
  end
end
