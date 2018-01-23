# frozen_string_literal: true

# Enforces ownership of applications
class Oauth::ApplicationsController < Doorkeeper::ApplicationsController
  before_action :authenticate_account!

  def index
    @applications = current_account.oauth_applications
  end

  def create
    @application = current_account.oauth_applications.new(application_params)

    if @application.save
      flash[:notice] = I18n.t(:notice, scope: %i[doorkeeper flash applications create])
    else
      render :new
    end
  end

  def set_application
    @application = current_account.oauth_applications.find(params[:id])
  end
end
