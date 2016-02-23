# Controller for the Dashboard view
class PagesController < ApplicationController
  before_action :authenticate_account!

  def dashboard
    @activities = Activity.active.order(:name).decorate
  end
end
