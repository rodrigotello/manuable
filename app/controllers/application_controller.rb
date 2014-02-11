# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from Exception, with: :catch_generic_exception
  force_ssl if: :ssl_configured?

  layout :set_layout
  before_filter :force_update_profile
  before_filter :beta, :stored_return_path
  before_filter :dev_user, if: proc { Rails.env.development? }

  protected

  def force_update_profile
    if current_user && self.class != My::ProfilesController && (current_user.email.include?('manuablefakeemail') || current_user.name.blank?)
      flash[:notice] = 'Por favor llenar tú correo y/o nombre antes de continuar.'
      redirect_to my_profile_path
    end
  end

  def catch_generic_exception exception
    raise exception if Rails.env == "development"
    # raise exception if exception.is_a? Rack::OAuth2::Server::Resource::Bearer::Unauthorized

    exception_message = exception.message
    exception_backtrace = exception.backtrace.join("\n")
    req_vars = {}
    req_vars[:http_host] = request.env["HTTP_HOST"] || "--"
    req_vars[:http_accept] = request.env["HTTP_ACCEPT"] || "--"
    req_vars[:http_user_agent] = request.env["HTTP_USER_AGENT"] || "--"
    req_vars[:http_referer] = request.env["HTTP_REFERER"] || "--"
    req_vars[:query_string] = request.env["rack.request.query_string"] || "--"
    req_vars[:request_parameters] = params.keys.empty? ? "--" : params.inspect
    req_vars[:http_x_requested_with] = request.env["HTTP_X_REQUESTED_WITH"] || "--"
    req_vars[:request_method] = request.env["REQUEST_METHOD"] || "--"
    ErrorMailer.an_error_was_found(request.url.to_s, exception_message, exception_backtrace, request.remote_ip.to_s, req_vars).deliver #if ENV['RAILS_ENV'] == 'production'

    logger.info exception_message + "\n" + exception_backtrace

  end

  def stored_return_path
    # raise 'storing'
    if params[:return_to].present?
      session[:rpath] = params[:return_to]
    end
  end

  def after_sign_in_path_for(resource)
    u = session[:rpath] || request.env['omniauth.origin'] || stored_location_for(resource) || root_path
    session[:rpath] = nil
    u
  end

  def god_mode?
    current_user && current_user.id == 43
  end
  def set_admin_locale
    I18n.locale = :en
  end

  def beta
    session[:beta] ||= params[:beta]
  end

  def set_layout
    return false if params[:no_layout] == "1" && params[:modal] != "1"
    return "modal" if params[:modal] == "1"
    "application"
  end

  def dev_user
    if params[:dev_user].present?
      sign_in :user, User.find(params[:dev_user])
    end
  end

  def ssl_configured?
    Rails.env.production?
  end
end
