# frozen_string_literal: true

# Controller actions for /teams
class TeamsController < ApplicationController
  before_action :forbid_non_owners, only: %i[edit update destroy]

  def index; end

  def new; end

  def create
    if team.save
      team.add_leader(current_account)
      flash[:notice] = "#{team.name} created successfully"
      redirect_to :root
    else
      render :new
    end
  end

  def edit; end

  def update
    if team.update_attributes(team_params)
      flash[:notice] = "#{team.name} successfully updated"
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if team.destroy
      flash[:notice] = "Deleted team #{team.name}"
    else
      flash[:error] = "Couldn't delete that team"
    end
    redirect_to root_path
  end

  helper_method def team
    @team ||= if params[:id]
                Team.find(params[:id])
              elsif params[:team]
                Team.new(team_params)
              else
                Team.new
              end
  end

  private def team_params
    params.require(:team).permit(:name, :member_ids, :activity_ids)
  end

  private def forbid_non_owners
    return if can_manage? team
    flash[:error] = "You don't have access to this team"
    redirect_to teams_path
  end

  def can_manage?(team)
    return false unless team
    team.leaders.include?(current_account)
  end
  helper_method :can_manage?
end
