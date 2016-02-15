# Web UI controller for Logs
class LogsController < ApplicationController
  before_action :setup_variables, only: [:new, :create, :edit, :update]

  def index
    @logs = LogsDecorator.new(current_account.logs.filter(params))
  end

  def new
  end

  def create
    if @log.save
      track_log_creation(@log.decorate)
      flash[:notice] = "Logged #{@log.decorate.summary}"
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    log = current_account.logs.find(params[:id])
    if log
      log.destroy
      flash[:notice] = "Deleted log for #{log.decorate.summary}"
    else
      flash[:error] = "Couldn't delete that log"
    end

    redirect_to root_path
  end

  def edit
    @project = Project.find(params[:project_id])
    @log = Log.find(params[:id])
  end

  def update
    if @log.update(log_params)
      flash[:notice] = "Edited #{@log.decorate.summary}"
      redirect_to root_path
    else
      render :edit
    end
  end

  private def log_params
    params.require(:log).permit(:quality, :amount, :worked_at, :do_not_bill, :notes)
      .merge(account: current_account, project: Project.find(params[:project_id]))
  end

  private def track_log_creation(log)
    track_event("Capacity Logged", worked_at: log.worked_at,
                                   amount: log.amount,
                                   billable: log.billable?,
                                   project_name: log.project.name,
                                   project_id: log.project.id)
  end

  private def load_project
    @project = Project.find(params[:project_id]) if params[:project_id]
  end

  private def load_log
    @log = if params[:id]
             Log.find(params[:id])
           elsif params[:log]
             Log.new(log_params)
           else
             Log.new(worked_at: Time.zone.today)
           end
  end

  private def setup_variables
    load_project
    load_log
  end
end
