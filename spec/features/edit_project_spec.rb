require "rails_helper"

feature "Edit projects" do
  Given!(:project) { FactoryGirl.create(:project, name: "Project A", capacity: 10) }
  Given!(:decorated_project) { project.decorate }

  include_context "account login"

  When { within("##{decorated_project.dom_id}") { click_link_or_button "Edit" } }

  context "successfully edits project" do
    When { fill_in "Capacity", with: 8 }
    When { click_link_or_button "Save" }

    Then { expect(project.reload.capacity).to eql(8) }
  end

  context "unsuccessfully edits project" do
    When { fill_in "Capacity", with: "" }
    When { click_link_or_button "Save" }

    Then { expect(project.reload.capacity).to eql(10) }
    Then { expect(page).to have_content("Capacity can't be blank") }
  end
end
