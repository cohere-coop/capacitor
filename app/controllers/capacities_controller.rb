class CapacitiesController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @capacity = Capacity.new
  end

  def create
    @project = Project.find(params[:project_id])
    @capacity = Capacity.new(capacity_params)
    @capacity.account = current_account
    @capacity.project = @project

    if @capacity.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def capacity_params
    params.require(:capacity).permit(:quality, :amount, :worked_at, :do_not_bill)
  end
end
