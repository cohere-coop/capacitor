# CRUD controller for Activities model
class ActivitiesController < ApplicationController
  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(activity_params)

    if @activity.save
      flash[:notice] = "New activity created"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @activity = Activity.find(params[:id])
  end

  def update
    @activity = Activity.find(params[:id])

    if @activity.update_attributes(activity_params)
      flash[:notice] = "Activity #{@activity.name} was updated"
      redirect_to root_path
    else
      render :edit
    end
  end

  def activity_params
    params.require(:activity).permit(:name, :capacity, :weekly_burn_rate, :billable, :active)
  end
end
