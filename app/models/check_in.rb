# Entry page used for tracking what was done during their activity
class CheckIn < ActiveRecord::Base
  has_many :logs
  belongs_to :account

  accepts_nested_attributes_for :logs

  def log_entries_attributes=(log_entries_attributes)
    self.logs_attributes = log_entries_attributes
  end

  def log_entries
    Activity.all.map do |activity|
      logs.new(activity: activity)
    end
  end
end
