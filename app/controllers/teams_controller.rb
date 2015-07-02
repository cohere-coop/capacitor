class TeamsController < ApplicationController
  before_action :setup_variables, only: [:new, :create]

  def new
  end

  def create
    if @team.save
      flash[:notice] = "#{@team.name} created successfully"
      redirect_to :root
    else
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
    params.require(:team).permit(:name, project_ids: []).merge(leader: current_account)
  end
  private "team_params"
end
