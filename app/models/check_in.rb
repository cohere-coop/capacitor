class CheckIn < ActiveRecord::Base
  has_many :logs
  belongs_to :account
  accepts_nested_attributes_for :logs

  def log_entries_attributes=

  end

  # TODO: Make this an attribute on the check_in model!
  def worked_at
  end

  def log_entries
    Activity.all.map do |activity|
      logs.new(activity: activity)
    end
  end
end
