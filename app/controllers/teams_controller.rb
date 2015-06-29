class TeamsController < ApplicationController
  before_action :setup_variables, only: [:new, :create]

  def new
    @teams_project = TeamsProject.new
  end

  def create
    @team.leader = current_account
    @team.save

    @teams_project = TeamsProject.new(teams_project_params)
    @teams_project.team_id = @team.id
    @teams_project.save

    if @teams_project.valid? && @team.valid?
      flash[:notice] = "#{@team.name} created successfully"
      redirect_to :root
    else
      # @projects = Project.active
      render :new
    end
  end

  def load_team
    if params[:team]
      @team = Team.new(team_params)
    else
      @team = Team.new
    end
  end
  private "load_team"

  def load_projects
    @projects = Project.active
  end
  private "load_projects"

  def setup_variables
    load_team
    load_projects
  end
  private "setup_variables"

  def team_params
    params.require(:team).permit(:name)
  end
  private "team_params"

  def teams_project_params
    params.require(:teams_project).permit(:project_id)
  end
  private "teams_project_params"
end
