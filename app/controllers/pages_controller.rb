class PagesController < ApplicationController
  before_action :authenticate_account!

  def dashboard
    @projects = Project.order(:name).decorate
  end
end
