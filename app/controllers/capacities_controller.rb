class CapacitiesController < ApplicationController

  def new
    @project = Project.find(params[:project_id])
  end

  def create
    capacity = current_account.capacities.create(capacity_params.merge(project_id: params[:project_id]))
    redirect_to root_path
  end

  private

  def capacity_params
    params.require(:capacity).permit(:quality, :amount, :worked_at, :do_not_bill)
  end

end
