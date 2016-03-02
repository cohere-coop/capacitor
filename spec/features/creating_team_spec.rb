require "rails_helper"

feature "Creating teams" do
  include_context "account login"

  Given!(:activity_1) { FactoryGirl.create(:activity, name: "Activity 1", owner: current_account) }
  Given!(:activity_2) { FactoryGirl.create(:activity, name: "Activity 2", owner: current_account) }
  Given!(:zee) { FactoryGirl.create(:account, name: "Zee Spencer") }
  Given!(:dicko) { FactoryGirl.create(:account, name: "Dicko Sow") }
  let(:team) { Team.find_by(name: "Team A") }

  When { visit teams_path }
  When { click_link_or_button "Create a team" }
  When { fill_in "Name", with: "Team A" }
  When { check "Activity 1" }
  When { check "Activity 2" }
  When { check "Zee Spencer" }
  When { check "Dicko Sow" }
  When { click_link_or_button "Create Team" }

  Then { expect(team).to be_persisted }
  Then { expect(current_account.owned_teams).to include(team) }
  Then { expect(team.activities).to include(activity_1) }
  Then { expect(team.activities).to include(activity_2) }
  Then { expect(team.accounts).to include(zee) }
  Then { expect(team.accounts).to include(dicko) }
end
