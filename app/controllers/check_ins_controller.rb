# /check_ins/{new, create}
class CheckInsController < ApplicationController
  def new
    @check_in = current_account.check_ins.new(check_in_params)
  end

  def create
    @check_in = current_account.check_ins.new(check_in_params)
    if @check_in.save
      flash[:notice] = "check in created!"
      track_check_in_creation(@check_in)
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @check_in = current_account.check_ins.find(params[:id])
  end

  def update
    @check_in = current_account.check_ins.find(params[:id])
    @check_in.update(check_in_params)
    flash[:notice] = "Check In updated!"
    redirect_to root_path
  end

  private def ensure_access!(attributes_collection, field, relation)
    @account_owns_all_policy ||= AccountOwnsAllPolicy.new(current_account)
    @account_owns_all_policy.ensure_access!(attributes_collection, field, relation)
  end

  private def check_in_params
    return {} unless params.key?(:check_in)
    check_in_params =
      params.require(:check_in).permit(permitted_check_in_params)
    check_in_params[:account] = current_account
    remove_empty_log_entries(check_in_params)
    merge_worked_at_and_account_into_log_entries(check_in_params)
    ensure_access!(check_in_params[:log_entries_attributes], :id, :logs)
    ensure_access!(check_in_params[:log_entries_attributes], :activity_id, :activities)
    check_in_params
  end

  private def merge_worked_at_and_account_into_log_entries(check_in_params)
    check_in_params.fetch(:log_entries_attributes, {}).each do |_id, log_entry|
      log_entry[:account] = current_account
      log_entry[:worked_at] = check_in_params[:worked_at]
    end
  end

  private def remove_empty_log_entries(check_in_params)
    check_in_params.fetch(:log_entries_attributes, {}).each do |id, log_entry|
      if log_entry[:quality].blank? || log_entry[:amount].blank?
        check_in_params[:log_entries_attributes].delete(id)
        next
      end
    end
  end

  private def permitted_check_in_params
    [:worked_at, log_entries_attributes: [:amount,
                                          :quality,
                                          :notes,
                                          :activity_id,
                                          :id]]
  end

  private def track_check_in_creation(check_in)
    track_event("Check in created", log_count: check_in.logs.count,
                                    worked_at: check_in.logs.first.worked_at)
  end
end
