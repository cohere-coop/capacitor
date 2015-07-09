class TeamsController < ApplicationController
  before_action :setup_variables, only: [:new, :create, :edit, :update, :destroy]

  def index
    @teams = Team.all.decorate
  end

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

  def edit
  end

  def update
    if @team.update_attributes(team_params)
      flash[:notice] = "#{@team.name} successfully updated"
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if @team.destroy
      flash[:notice] = "Deleted team #{@team.name}"
    else
      flash[:error] = "Couldn't delete that team"
    end
    redirect_to root_path
  end

  def load_team
    if params[:id]
      @team = Team.find(params[:id])
    elsif params[:team]
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

  def load_accounts
    @accounts = Account.all
  end
  private "load_accounts"

  def setup_variables
    load_team
    load_projects
    load_accounts
  end
  private "setup_variables"

  def team_params
    params.require(:team).permit(:name, project_ids: [], account_ids: []).merge(leader: current_account)
  end
  private "team_params"
end
