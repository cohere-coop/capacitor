class MissingCheckInPreview < ActionMailer::Preview
  def missing_check_in
    MissingCheckInMailer.missing_check_in(Account.first, 1.day.ago)
  end
end