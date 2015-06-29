require "rails_helper"

feature "Creating teams" do
  Given!(:project) { FactoryGirl.create(:project, name: "Project A", capacity: 10) }
  let(:team) { Team.find_by(name: "Team A") }

  include_context "account login"

  When { click_link_or_button "Create a team" }
  When { fill_in "Name", with: "Team A" }
  When { select "Project A", from: "Project" }
  When { click_link_or_button "Create Team" }

  Then { expect(team).to be_persisted }
  Then { expect(team.leader).to eql(current_account) }
end
