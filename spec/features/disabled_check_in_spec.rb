require "rails_helper"

feature "Check in for account not enabled" do
  include_context "account login"

  Given { (current_account.features.check_in = false) && current_account.save }
end
