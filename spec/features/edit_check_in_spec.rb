require "rails_helper"

feature "Edit check in" do
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
  Given!(:fun_activity) { FactoryGirl.create(:activity, name: "Have Fun") }
  Given!(:work_activity) { FactoryGirl.create(:activity, name: "Do Work") }
  Given!(:check_in) { FactoryGirl.create(:check_in, account: current_account) }
  Given(:decorated_check_in) { check_in.decorate }
  Given { (current_account.features.check_in = true) && current_account.save }
  describe "Edit a bunch of activities" do
    When do
      check_in.logs.create(activity: fun_activity, quality: 4, amount: 2, worked_at: check_in.worked_at)
      check_in.logs.create(activity: work_activity, quality: 1, amount: 3, worked_at: check_in.worked_at)
      visit root_path
      within(:xpath, "//li[@id=\"#{decorated_check_in.dom_id}\"]") do
        click_link_or_button("Edit")
      end

      fill_in("What day is this for?", with: "2016-05-03")

      select_quantity(fun_activity, "2~4 hours")
      fill_in_notes(fun_activity, "Not so much fun, but still fun")
      select_quality(fun_activity, "Good! I was REALLY focused")

      select_quantity(work_activity, "6~8 hours")
      fill_in_notes(work_activity, "Did more than I thought!!!")
      select_quality(work_activity, "Great! It was Like I was super powered!")

      click_link_or_button("Update Check in")
    end
    Then do
      expect(work_log_entry.notes).to eql "Did more than I thought!!!"
      expect(work_log_entry.quality).to eql 4
      expect(work_log_entry.amount).to eql 8

      expect(fun_log_entry.notes).to eql "Not so much fun, but still fun"
      expect(fun_log_entry.quality).to eql 3
      expect(fun_log_entry.amount).to eql 4
    end
  end
end
