require "rails_helper"

feature "Checking in" do
  include_context "account login"

  def select_quantity(activity, quantity)
    within "#activity-#{activity.id}" do
      select quantity, from: "How much time did you spend on it?"
    end
  end

  def select_quality(activity, quality)
    within "#activity-#{activity.id}" do
      select quality, from: "How'd it go?"
    end
  end

  let(:worked_at) { Date.new.strftime("%Y-%m-%d") }
  let(:fun_log_entry) { fun_activity.logs.find_by(worked_at: worked_at) }
  let(:work_log_entry) { fun_activity.logs.find_by(worked_at: worked_at) }

  Given!(:fun_activity) { FactoryGirl.create(:activity, name: "Have Fun") }
  Given!(:work_activity) { FactoryGirl.create(:activity, name: "Do Work") }

  When { click_link_or_button "Check in" }
  When { fill_in("What day is this for?", with: worked_at) }

  When { select_quantity(fun_activity, 2) }
  When { fill_in_notes(fun_activity, "SO MUCH FUN") }
  When { select_quality(fun_activity, 4) }

  When { select_quantity(work_activity, 6) }
  When { fill_in_notes(work_activity, "DID SO MUCH") }
  When { select_quality(work_activity, 3) }

  When { click_link_or_button("Create Check in") }

  Then { work_log_entry.notes == "DID SO MUCH" }
  Then { work_log_entry.quality == 3 }
  Then { work_log_entry.quantity == 6 }

  Then { fun_log_entry.notes == "SO MUCH FUN" }
  Then { fun_log_entry.quality == 4 }
  Then { fun_log_entry.quantity == 2 }
end
