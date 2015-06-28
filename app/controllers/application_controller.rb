class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_time_zone


  include SegmentRails

  def user_identifier
    current_account ? current_account.id : nil
  end

  alias_method :devise_current_account, :current_account

  def current_account
    devise_current_account.present? ? devise_current_account.decorate : nil
  end

  def set_time_zone
    Time.zone = current_account.time_zone if current_account
  end
end
