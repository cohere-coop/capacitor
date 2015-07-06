feature "Reviewing logged capacity" do
  include_context "account login"

  Given!(:recent_log) { FactoryGirl.create(:recent_log, account: current_account).decorate }
  Given!(:old_log) { FactoryGirl.create(:old_log, account: current_account).decorate }

  Then { within("##{recent_log.dom_id}") { expect(page).to have_content(recent_log.worked_at) } }
  Then { within("##{recent_log.dom_id}") { expect(page).to have_content(recent_log.project.name) } }
  Then { within("##{recent_log.dom_id}") { expect(page).to have_content(recent_log.billable?) } }
  Then { expect(page).not_to have_selector("#{old_log.dom_id}") }
end
