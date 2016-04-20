require "rails_helper"
feature "Reviewing recent check ins" do
  include_context "account login"

  Given!(:recent_check_in) { FactoryGirl.create(:recent_check_in, account: current_account).decorate }
  Given!(:old_check_in) { FactoryGirl.create(:old_check_in, account: current_account).decorate }

  Then { within("##{recent_check_in.dom_id}") { expect(page).to have_content(recent_check_in.worked_at) } }
  Then { within("##{recent_check_in.dom_id}") { expect(page).to have_content(recent_check_in.logs_summary) } }
  Then { expect(page).not_to have_selector("##{old_check_in.dom_id}") }
end