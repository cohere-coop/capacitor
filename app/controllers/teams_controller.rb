class TeamsController < ApplicationController
  def new
    @team = Team.new
    @teams_project = TeamsProject.new
    @projects = Project.active
  end

  def create
    @team = Team.new(team_params)
    @team.leader = current_account
    @team.save

    @teams_project = TeamsProject.new(teams_project_params)
    @teams_project.team = @team
    @teams_project.save

    if @teams_project.valid? && @team.valid?
      flash[:notice] = "#{@team.name} created successfully"
      redirect_to :root
    else
      @projects = Project.active
      render :new
    end
  end

  def team_params
    params.require(:team).permit(:name)
  end
  private "team_params"

  def teams_project_params
    params.require(:teams_project).permit(:project_id)
  end
  private "teams_project_params"
end
