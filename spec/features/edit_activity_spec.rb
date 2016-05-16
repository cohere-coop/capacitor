require "rails_helper"

feature "Edit activities" do
  include_context "account login"

  Given!(:activity) { FactoryGirl.create(:activity, name: "Activity A", capacity: 10, owner: current_account) }
  Given!(:decorated_activity) { activity.decorate }

  When { within("##{decorated_activity.dom_id}") { click_link_or_button "Edit" } }

  context "successfully edits activity" do
    When { fill_in "Name", with: "Activity B" }
    When { click_link_or_button "Save" }

    Then { expect(activity.reload.name).to eql("Activity B") }
  end

  context "unsuccessfully edits activity" do
    When { fill_in "Name", with: "" }
    When { click_link_or_button "Save" }

    Then { expect(activity.reload.name).to eql("Activity A") }
    Then { expect(page).to have_content("Name can't be blank") }
  end
end
