require "rails_helper"

feature "Edit activities" do
  include_context "account login"

  Given!(:activity) { FactoryGirl.create(:activity, name: "Activity A", capacity: 10, owner: current_account) }
  Given!(:decorated_activity) { activity.decorate }

  When { within("##{decorated_activity.dom_id}") { click_link_or_button "Edit" } }

  context "successfully edits activity" do
    When { fill_in "Capacity", with: 8 }
    When { click_link_or_button "Save" }

    Then { expect(activity.reload.capacity).to eql(8) }
  end

  context "unsuccessfully edits activity" do
    When { fill_in "Capacity", with: "" }
    When { click_link_or_button "Save" }

    Then { expect(activity.reload.capacity).to eql(10) }
    Then { expect(page).to have_content("Capacity can't be blank") }
  end
end
