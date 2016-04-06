# Controller for the Dashboard view
class PagesController < ApplicationController
  before_action :authenticate_account!

  def dashboard
    @activities = current_account.active_activities
  end

  helper_method def check_ins
    @check_ins ||= current_account.check_ins
  end
end
