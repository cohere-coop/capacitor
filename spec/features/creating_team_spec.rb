require "rails_helper"

feature "Creating teams" do
  Given!(:project_1) { FactoryGirl.create(:project, name: "Project 1") }
  Given!(:project_2) { FactoryGirl.create(:project, name: "Project 2") }
  Given!(:zee) { FactoryGirl.create(:account, name: "Zee Spencer") }
  Given!(:dicko) { FactoryGirl.create(:account, name: "Dicko Sow") }
  let(:team) { Team.find_by(name: "Team A") }

  include_context "account login"

  When { click_link_or_button "Create a team" }
  When { fill_in "Name", with: "Team A" }
  When { check "Project 1" }
  When { check "Project 2" }
  When { check "Zee Spencer" }
  When { check "Dicko Sow" }
  When { click_link_or_button "Create Team" }

  Then { expect(team).to be_persisted }
  Then { expect(team.leader).to eql(current_account) }
  Then { expect(team.projects).to include(project_1) }
  Then { expect(team.projects).to include(project_2) }
  Then { expect(team.accounts).to include(zee) }
  Then { expect(team.accounts).to include(dicko) }
end
