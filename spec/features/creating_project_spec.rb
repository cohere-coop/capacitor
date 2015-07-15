require "rails_helper"

feature "Creating projects" do
  include_context "account login"

  Given!(:team) { FactoryGirl.create(:team, name: "Team A") }

  When { click_link_or_button "Create a new project" }
  When { fill_in "Name", with: "Project A" }
  When { fill_in "Capacity", with: 10 }
  When { fill_in "Weekly burn rate", with: 5 }
  When { check "Team A" }
  When { click_link_or_button "Create project" }

  Then { expect(Project.find_by(name: "Project A")).to be_persisted }
  Then { expect(Project.find_by(name: "Project A").teams).to include(team) }
end
