# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_account!
  decorates_assigned :check_ins
  decorates_assigned :activities
  def dashboard
    @activities = current_account.active_activities

    if current_account.features.check_in?
      @check_ins = CheckIns::Account.new(current_account).recent_check_ins
      render "check_ins/dashboard"
    else
      render :dashboard
    end
  end
end
