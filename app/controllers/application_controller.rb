class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SegmentRails

  alias_method :devise_current_account, :current_account
  def current_account
    devise_current_account.present? ? devise_current_account.decorate : nil
  end
end
