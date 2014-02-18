class Api::ApplicationController < ActionController::Base
  skip_before_filter :verify_authenticity_token

  rescue_from Exception, with: :catch_generic_exception
  # rescue_from ActiveRecord::RecordNotFound, :with => :catch_not_found_error
  # rescue_from InteamExceptions::NotFoundError, :with => :catch_not_found_error
  # rescue_from InteamExceptions::NotEnoughPermissionsError, :with => :catch_not_enough_permission
  # rescue_from InteamExceptions::MissingParametersError, :with => :catch_bad_parameters_error
  # rescue_from InteamExceptions::UnexpectedError, :with => :catch_unexpected_error
  # rescue_from ActionController::RoutingError, :with => :catch_route_not_found

  respond_to :json
  force_ssl if: :ssl_configured?

  before_filter :authenticate!
  before_filter :beta
  before_filter :dev_user, if: proc { Rails.env.development? }

  protected

  def authenticate!
    # check out config/initializers/http_token.rb authenticate_or_request_with_http_token behevior modification

    authenticate_or_request_with_http_token do |token, options|
      if token.blank?
        render json: { http_status: '401', code: 'access_token.invalid' }
      else
        if @current_token = AccessToken.valid.where(token: token).first
          true
        else
          false
        end
      end

    end
  end

  def force_update_profile
    if current_user && (current_user.email.include?('manuablefakeemail') || current_user.name.blank?)
      render json: { :redirect_to => 'my/profile' }
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

  def god_mode?
    current_user && current_user.id == 43
  end

  def beta
    session[:beta] ||= params[:beta]
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
