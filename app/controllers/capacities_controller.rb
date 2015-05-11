class CapacitiesController < ApplicationController

  def new
    @capacity.project = Project.find(params[:project_id])

    # Had to add this so that we could call errors on @capacity. But now getting error about undefined method for nilClass on project
    @capacity = Capacity.new
  end

  def create
    @project = Project.find(params[:project_id])
    @capacity = current_account.capacities.create(capacity_params.merge(project_id: params[:project_id]))

    if @capacity.valid?
      redirect_to root_path
    else
      @project = @capacity.project
      render :new
      @capacity.errors.full_messages
    end
  end

  private

  def capacity_params
    params.require(:capacity).permit(:quality, :amount, :worked_at, :do_not_bill)
  end

end
