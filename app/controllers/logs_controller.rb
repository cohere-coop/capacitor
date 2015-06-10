class LogsController < ApplicationController
  before_action :setup_variables, only: [:new, :create]

  def index
    search = SearchDenormalizer.new(params[:search] || {})
    logs = search.scopes.inject(Log) do |query, scope|
      query.public_send(scope, *search.arguments[scope])
    end
    @logs = LogsDecorator.new(logs)
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

  def setup_variables
    @project = Project.find(params[:project_id]) if params[:project_id]
    @log = params[:log] ? Log.new(log_params) : Log.new(worked_at: Time.zone.today)
  end
  private "setup_variables"
end
