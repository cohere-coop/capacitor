class MissingCheckInNotifier
  def self.notify
    inactive_accounts = Account.all.select do |account|
      yesterday = (1.day.ago.beginning_of_day..1.day.ago.end_of_day)
      account.check_ins.where(worked_at: yesterday).empty?
    end
    inactive_accounts.each do |account|
      puts MissingCheckInMailer.missing_check_in(account, 1.day.ago).deliver_now
    end
  end
end