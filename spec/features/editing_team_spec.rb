require "rails_helper"

feature "Editing teams" do
  include_context "account login"

  Given!(:project_1) { FactoryGirl.create(:project, name: "Project 1") }
  Given!(:zee) { FactoryGirl.create(:account, name: "Zee Spencer") }

  Given!(:team) { FactoryGirl.create(:team, name: "Unicorns") }
  Given { team.add_leader(current_account) }

  Given!(:decorated_team) { team.decorate }

  When { visit teams_path }
  When { within("##{decorated_team.dom_id}") { click_link_or_button "Edit" } }

  When { fill_in "Name", with: "Team A" }
  When { check "Project 1" }
  When { check "Zee Spencer" }
  When { click_link_or_button "Save" }

  Then { expect(team.reload.name).to eql("Team A") }
  Then { expect(team.reload.projects).to include(project_1) }
  Then { expect(team.reload.accounts).to include(zee) }
end
