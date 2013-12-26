class ApplicationController < ActionController::Base
  protect_from_forgery
  force_ssl if: :ssl_configured?

  layout :set_layout
  before_filter :beta
  before_filter :dev_user, if: proc { Rails.env.development? }

  protected
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
