#encoding: utf-8
module EventsHelper
  def request_link event, text=nil
    output = ""
    event_request = event.event_requests.where(user_id: current_user.id).first
    event_payment = event.event_payments.where(user_id: current_user.id).first
    if signed_in? && (event_request || event_payment)
      if event_request.accepted.nil?
        output << link_to("¡#{ text || "Esperando respuesta" }!".html_safe, request_access_event_path, class: 'request-access btn-warning', rel: 'modal', title: '¡Quiero participar!', data: { modalclass: 'request-access-modal' })
      elsif event_request.accepted
        if event_payment && event_payment.paid?
          output << link_to("Gracias por participar!".html_safe, 'javascript:void(1)', class: 'request-access') unless event.info_for_accepted_users.present?
        else
          output << link_to("¡Aceptada! pasar a paga".html_safe, checkout_event_path(event), class: 'request-access')
        end
        # output << link_to(event.info_for_accepted_users.html_safe, 'javascript:void(1)', class: 'request-access') if event.info_for_accepted_users.present?
      else
        output << "<div class='btn btn-danger disabled'> Rechazada </div>"
      end
    else
      if event.seats_left?
        if signed_in?
          output << link_to("¡#{ text || "Quiero participar" }!".html_safe, request_access_event_path, class: 'request-access', rel: 'modal', title: '¡Quiero participar!', data: { modalclass: 'request-access-modal' })
        else
          output << link_to("¡#{ text || "Quiero participar" }!".html_safe, "#sign_popup", "data-toggle" => "modal", :role => "button", class: 'request-access')
        end
      end
    end
    output.html_safe
  end

end
