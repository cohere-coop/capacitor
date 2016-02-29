class CheckInsController < ApplicationController
  # before_action :setup_variables, only: [:new, :create]
  def index
    @check_in = CheckInDecorator.new(current_account.filter(check_in_params))
  end

  def create
    if @check_in.save
      check_in_creation(@check_in.decorate)
      flash[:notice] = "Check In #{@check_in.decorate.summary}"
      redirect_to root_path
    else
      render :new
    end
  end

  def new
    @check_in = CheckIn.new(account: current_account)
  end

  private def check_in_creation(check_in)
    track_event("Check In Created", worked_at: check_in.worked_at,
                                    amount: check_in.amount,
                                    billable: check_in.billable? )

  end

  private def check_in_params
    params.require(:check_in).permit(:quality, :amount, :notes, :worked_at, :do_not_bill)
    .merge(account: current_account, activity: Activity.find(params[:activity_id]))
  end
end
