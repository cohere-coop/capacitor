class PagesController < ApplicationController
  before_action :authenticate_account!

  def dashboard
    @projects = ProjectDecorator.decorate_collection(Project.order(:name))
  end
end
