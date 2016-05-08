# Base controller for Web/UI Views
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from UnauthorizedActionError, with: :deny_access
  before_action :authenticate_account!
  around_action :ensure_user_timezone

  include SegmentRails

  def user_identifier
    current_account ? current_account.id : nil
  end

  alias devise_current_account current_account

  def current_account
    devise_current_account.present? ? devise_current_account.decorate : nil
  end

  private def ensure_user_timezone(&block)
    if account_signed_in?
      Time.use_zone(current_account.time_zone, &block)
    else
      yield
    end
  end

  private def deny_access
    sign_out
    redirect_to root_path
  end
end
