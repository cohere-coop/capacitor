require "rails_helper"

feature "Logging time" do
  include_context "account login"

  let(:worked_at) { "2015-05-06" }
  let(:log) { Log.find_by(worked_at: worked_at) }

  Given!(:project) { FactoryGirl.create(:project) }

  When { click_link_or_button project.name }

  When { select("1 half-day", from: "Amount") }
  When { select("4", from: "Quality") }
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
