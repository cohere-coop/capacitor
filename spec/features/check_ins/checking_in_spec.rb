require "rails_helper"

feature "Checking in" do
  include_context "account login"

  def activity_div(activity)
    find("#activity-#{activity.id}")
  end

  def select_quantity(activity, quantity)
    activity_div(activity)
      .select quantity, from: "How many hours did you work?"
  end

  def select_quality(activity, quality)
    activity_div(activity)
      .select quality, from: "How'd it go?"
  end

  def fill_in_notes(activity, content)
    activity_div(activity)
      .fill_in("Notes", with: content)
  end

  let(:worked_at) { 1.day.ago.strftime("%Y-%m-%d") }
  let(:fun_log_entry) { fun_activity.logs.last }
  let(:work_log_entry) { work_activity.logs.last }
  Given { (current_account.features.check_in = true) && current_account.save }
  Given!(:fun_activity) { FactoryGirl.create(:activity, name: "Have Fun", owner: current_account) }
  Given!(:work_activity) { FactoryGirl.create(:activity, name: "Do Work", owner: current_account) }


  describe "Checking in via the check-in link the dashboard" do
    When { click_link_or_button "Check In" }

    When { fill_in("What day is this for?", with: worked_at) }

    When { select_quantity(fun_activity, "1~2 hours") }
    When { fill_in_notes(fun_activity, "SO MUCH FUN") }
    When { select_quality(fun_activity, "Great! It was Like I was super powered!") }

    When { select_quantity(work_activity, "4~6 hours") }
    When { fill_in_notes(work_activity, "DID SO MUCH") }
    When { select_quality(work_activity, "Good! I was REALLY focused") }

    When { click_link_or_button("Create Check in") }

    Then { work_log_entry.notes == "DID SO MUCH" }
    Then { work_log_entry.quality == 3 }
    Then { work_log_entry.amount == 6 }

    Then { fun_log_entry.notes == "SO MUCH FUN" }
    Then { fun_log_entry.quality == 4 }
    Then { fun_log_entry.amount == 2 }
  end
  describe "Last 7 days are listed for checking in" do
    Given!(:check_in) { FactoryGirl.create(:check_in, account: current_account, worked_at: Time.zone.now) }
    Then do
      expect(page).to have_content("#{0.days.ago.to_date.strftime("%A %B %-d")} - Edit")
      6.times do |n|
        expect(page).to have_content("#{(n+1).days.ago.to_date.strftime("%A %B %-d")} - Check in")
      end
    end
  end

  describe "Checking in via the list of recent check ins" do
    When { within("#check-in-#{2.days.ago.to_date}") { click_link_or_button "Check in"} }
    Then { expect(find("#check_in_worked_at").value).to eql 2.days.ago.to_date.to_s }
  end

  describe "Check in page doesn't show archived activities" do
    Given!(:archived_activity) { FactoryGirl.create(:archived_activity) }
    When { click_link_or_button "Check In" }
    Then { expect(page).not_to have_content(archived_activity.name) }
    Then { expect(activity_div(fun_activity)).to be_present }
    Then { expect(activity_div(work_activity)).to be_present }
  end
end
