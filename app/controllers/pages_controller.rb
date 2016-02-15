# Controller for the Dashboard view
class PagesController < ApplicationController
  before_action :authenticate_account!

  def dashboard
    @projects = Project.active.order(:name).decorate
  end
end
