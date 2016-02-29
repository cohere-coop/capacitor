class CheckInsController < ApplicationController
  # before_action :setup_variables, only: [:new, :create]
  def index
  end

  def create
    if @check_in.save
      
  end

  def new
    @check_in = CheckIn.new(account: current_account)
  end
end
