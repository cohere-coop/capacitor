require "rails_helper"

feature "Edit check in" do
  include_context "account login"

  let(:worked_at) { 1.day.ago.strftime("%Y-%m-%d") }
  let(:fun_log_entry) { fun_activity.logs.last }
  let(:work_log_entry) { work_activity.logs.last }
  Given { (current_account.features.check_in = true) && current_account.save }
  describe "Edit a bunch of activities" do
    it "Edits activites within a check in" do
      within(:xpath, "//li[@id=\"#{check_in.dom_id}\"]") do
        click_link_or_button("Edit")
      end

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
  end
end
