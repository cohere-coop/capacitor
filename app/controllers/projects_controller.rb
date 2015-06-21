class ProjectsController < ApplicationController
  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      flash[:notice] = "New project created"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])

    if @project.update_attributes(project_params)
      flash[:notice] = "Project #{@project.name} was updated"
      redirect_to root_path
    else
      render :edit
    end
  end

  def project_params
    params.require(:project).permit(:name, :capacity, :weekly_burn_rate, :billable, :active)
  end
end
