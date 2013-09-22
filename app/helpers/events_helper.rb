#encoding: utf-8
module EventsHelper
  def request_link event
    output = ""
    if signed_in? && (event_request = event.event_requests.where(user_id: current_user.id).first)
      if event_request.accepted.nil?
        output << "<div class='disabled pull-right request-access'>
          <br>
          Esperando
          <br>
          respuesta
        </div>"
      elsif event_request.accepted
        output << link_to("<br>¡Aceptada!<br> pasar a paga".html_safe, checkout_event_path(event), class: 'pull-right request-access')
      else
        output << "<div class='btn btn-danger disabled'>
          Rechazada
        </div>"
      end
    else
      if event.seats_left?
        if signed_in?
          output << link_to('<br>Haz click <br> aquí para <br> participar!'.html_safe, request_access_event_path, class: 'pull-right request-access', rel: 'modal', title: '¡Envía tu Solicitud!', data: { modalclass: 'request-access-modal' })
        else
          output << link_to('<br>¡Haz click <br> aquí para <br> participar!'.html_safe, "#sign_popup", "data-toggle" => "modal", :role => "button", class: 'pull-right request-access')
        end
      end
    end
    output.html_safe
  end

end
