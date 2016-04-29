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
  Given!(:fun_activity) { FactoryGirl.create(:activity, name: "Have Fun") }
  Given!(:work_activity) { FactoryGirl.create(:activity, name: "Do Work") }

  When { click_link_or_button "Check In" }

  describe "Logging a bunch of activities" do
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

  describe "Edit a bunch of activities" do
    When { click_link_or_button("Edit") }
    When { fill_in("What day is this for?", with: "2016-05-03") }

    When { select_quantity(fun_activity, "2~4 hours") }
    When { fill_in_notes(fun_activity, "Not so much fun, but still fun") }
    When { select_quality(fun_activity, "Good! I was REALLY focused") }

    When { select_quantity(work_activity, "6~8 hours") }
    When { fill_in_notes(work_activity, "Did more than I thought!!! ") }
    When { select_quality(work_activity, "Great! It was Like I was super powered!") }

    When { click_link_or_button("Update Check in") }

    Then { work_log_entry.notes == "Did more than I thought!!!" }
    Then { work_log_entry.quality == 4 }
    Then { work_log_entry.amount == 8 }

    Then { fun_log_entry.notes == "Not so much fun but still fun" }
    Then { fun_log_entry.quality == 3 }
    Then { fun_log_entry.amount == 4 }
  end

  describe "Archived activities" do
    Given!(:archived_activity) { FactoryGirl.create(:archived_activity) }

    Then { expect(page).not_to have_content(archived_activity.name) }
    Then { expect(activity_div(fun_activity)).to be_present }
    Then { expect(activity_div(work_activity)).to be_present }
  end
end
