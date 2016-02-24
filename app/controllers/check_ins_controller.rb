class CheckInsController < ApplicationController

  def new
    @check_in = CheckIn.new(account: current_account)
  end
end
