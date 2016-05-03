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
  Given { (current_account.features.check_in = true) && current_account.save }
  Given(:fun_activity) { FactoryGirl.create(:activity, name: "Have Fun", owner: current_account) }
  Given(:work_activity) { FactoryGirl.create(:activity, name: "Do Work", owner: current_account) }
  Given(:recent_check_in) { FactoryGirl.create(:check_in, worked_at: 2.days.ago, account: current_account) }
  Given { recent_check_in.update(log_entries_attributes: { 0 => { activity: fun_activity, amount: 1, quality: 1, account: current_account }, 1 => { activity: work_activity, amount: 6, quality: 2, account: current_account }}) }
  let(:decorated_check_in) { recent_check_in.decorate }
  describe "Edit a bunch of activities" do
    When do
      within "##{decorated_check_in.dom_id}" do
        click_link("Edit")
      end
    end

    When { fill_in("What day is this for?", with: "2016-05-03") }

    When { select_quantity(fun_activity, "2~4 hours") }
    When { fill_in_notes(fun_activity, "Not so much fun, but still fun") }
    When { select_quality(fun_activity, "Good! I was REALLY focused") }

    When { select_quantity(work_activity, "6~8 hours") }
    When { fill_in_notes(work_activity, "Did more than I thought!!!") }
    When { select_quality(work_activity, "Great! It was Like I was super powered!") }

    When { click_link_or_button("Update Check in") }

    Then { work_log_entry.notes == "Did more than I thought!!!" }
    Then { work_log_entry.quality == 4 }
    Then { work_log_entry.amount == 8 }

    Then { fun_log_entry.notes == "Not so much fun, but still fun" }
    Then { fun_log_entry.quality == 3 }
    Then { fun_log_entry.amount == 4 }
  end
end
