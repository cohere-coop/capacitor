class TeamsController < ApplicationController
  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      flash[:notice] = "#{@team.name} created successfully"
      redirect_to :root
    else
      render :new
    end
  end


  def team_params
    params.require(:team).permit(:name).merge(leader: current_account)
  end
  private "team_params"
end
