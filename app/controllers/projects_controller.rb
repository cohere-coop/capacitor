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

  def project_params
    params.require(:project).permit(:name, :capacity, :weekly_burn_rate, :billable, :active)
  end
end
