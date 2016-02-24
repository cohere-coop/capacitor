class CheckIn < ActiveRecord::Base
  has_many :logs
  belongs_to :account
  accepts_nested_attributes_for :logs

  def log_entries_attributes=
  end

  def log_entries
    Activity.all.each do |activity|
      logs.new(activity: activity)
    end
    return logs
  end
end
