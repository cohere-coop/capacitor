namespace :capacitor do
  desc "Notify accounts that they have not checked in for the previous day by noon"
  task notify_accounts_of_missing_checkins: :environment do
    require_dependency "missing_check_in_notifier"
    MissingCheckInNotifier.notify
  end
end
