# Controller for the Dashboard view
class PagesController < ApplicationController
  before_action :authenticate_account!

  def dashboard
    @activities = current_account.active_activities
  end
end
