class LogsController < ApplicationController
  DEFAULT_SEARCH = {
    scopes: ["recent"],
    recent: 21
  }

  before_action :setup_variables, only: [:new, :create]
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

  def log_params
    params.require(:log).permit(:quality, :amount, :worked_at, :do_not_bill)
      .merge(account: current_account, project: Project.find(params[:project_id]))
  end
  private "log_params"

  def track_log_creation(log)
    track_event("Capacity Logged", worked_at: log.worked_at,
                                   amount: log.amount,
                                   billable: log.billable?,
                                   project_name: log.project.name,
                                   project_id: log.project.id)
  end
  private "track_log_creation"

  def load_project
    @project = Project.find(params[:project_id]) if params[:project_id]
  end

  def load_log
    if params[:id]
      @log = Log.find(params[:id])
    elsif params[:log]
      @log = Log.new(log_params)
    else
      @log = Log.new(worked_at: Time.zone.today)
    end
  end

  def setup_variables
    load_project
    load_log
  end
  private "setup_variables"


end
