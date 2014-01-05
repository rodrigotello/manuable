class ApplicationController < ActionController::Base
  protect_from_forgery
  force_ssl if: :ssl_configured?

  layout :set_layout
  before_filter :beta, :stored_return_path
  before_filter :dev_user, if: proc { Rails.env.development? }

  protected

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
