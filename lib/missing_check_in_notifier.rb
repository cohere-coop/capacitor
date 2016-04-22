# Finds and notifies accounts of missing check in from one day ago
class MissingCheckInNotifier
  def self.inactive_accounts
    Account.all.select do |account|
      yesterday = (1.day.ago.beginning_of_day..1.day.ago.end_of_day)
      account.check_ins.where(worked_at: yesterday).empty?
    end
  end

  def self.notify
    inactive_accounts.each do |account|
      if account.where(check_ins: true) do
      MissingCheckInMailer.missing_check_in(account, 1.day.ago).deliver_now
    else
      
    end
    end
  end
end
