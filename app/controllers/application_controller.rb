class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :set_layout
  before_filter :beta

  protected

  def beta
    session[:beta] ||= params[:beta]
  end

  def set_layout
    return false if params[:no_layout] == "1"
    return "modal" if params[:modal] == "1"
    "application"
  end
end
