require 'rails_helper'

feature 'Logging time' do
  include_context "account login"

  Given!(:project_to_work_on) { FactoryGirl.create(:project) }
  Given!(:project_not_to_work_on) { FactoryGirl.create(:project) }

  When { click_link_or_button project_to_work_on.name }

  When { select("1 half-day", from: "Amount") }
  When { select("4", from: "Quality") }
  When { fill_in("Worked at", with: "2015-05-06") }

  context "when tracking time as billable" do
    When { click_link_or_button "Log Capacity" }
    Then { expect(Capacity.find_by(worker: current_account, amount: 4, quality: 4, worked_at: "2015-05-06", do_not_bill: false, project: project_to_work_on)).to be_present }
  end

  context "when tracking time as do not bill" do
    When { check("Do Not Bill")}
    When { click_link_or_button "Log Capacity" }
    Then { expect(Capacity.find_by(worker: current_account, amount: 4, quality: 4, worked_at: "2015-05-06", do_not_bill: true, project: project_to_work_on)).to be_present }
  end
end
