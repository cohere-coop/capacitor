require "rails_helper"

feature "Creating teams" do
  include_context "account login"

  When { click_link_or_button "Create a team" }
  When { fill_in "Name", with: "Team A" }
  When { click_link_or_button "Create Team" }

  Then { expect(Team.find_by(name: "Team A")).to be_persisted }
  Then { expect(Team.find_by(name: "Team A").leader).to eql(current_account) }
end
