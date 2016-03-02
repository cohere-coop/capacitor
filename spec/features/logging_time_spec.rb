require "rails_helper"

feature "Logging time" do
  include_context "account login"

  let(:worked_at) { "2015-05-06" }
  let(:log) { Log.find_by(worked_at: worked_at) }

  Given!(:activity) { FactoryGirl.create(:activity, owner: current_account) }

  When { click_link_or_button "#{activity.id}_new_log_entry" }

  When { select("1 half day", from: "Amount") }
  When { select("😌", from: "How'd it go?") }
  When { fill_in("Worked at", with: worked_at) }

  context "when tracking time as billable" do
    When { click_link_or_button("Log Capacity") }
    Then { expect(log.do_not_bill).to be(false) }
    Then { expect(log).to be_persisted }
  end

  context "when tracking time as do not bill" do
    When { check("Do Not Bill") }
    When { click_link_or_button("Log Capacity") }
    Then { expect(log.do_not_bill).to be(true) }
    Then { expect(log).to be_persisted }
  end
end

feature "Editing time" do
  include_context "account login"

  Given!(:activity) { FactoryGirl.create(:activity, owner: current_account) }
  Given!(:log) { current_account.logs.create(activity: activity, quality: 1, amount: 1, worked_at: 1.day.ago) }
  Given!(:decorated_log) { log.decorate }

  When { within("##{decorated_log.dom_id}") { click_link_or_button("Edit") } }
  When { select("😄", from: "How'd it go?") }
  When { click_link_or_button("Log Capacity") }
  Then { expect(log.reload.quality).to eql(5) }
end
