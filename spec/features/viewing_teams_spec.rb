require "rails_helper"

feature "Viewing teams" do
  include_context "account login"

  Given!(:zee) { FactoryGirl.create(:account, name: "Zee Spencer") }
  Given!(:dicko) { FactoryGirl.create(:account, name: "Dicko Sow") }

  Given!(:unicorns) { FactoryGirl.create(:team, name: "Unicorns", leader: current_account).decorate }
  Given!(:dinosaurs) { FactoryGirl.create(:team, name: "Dinosaurs", leader: dicko).decorate }
  Given!(:giraffes) { FactoryGirl.create(:team, name: "Giraffes").decorate }

  Given!(:membership_1) { FactoryGirl.create(:membership, team: unicorns, account: zee) }
  Given!(:membership_2) { FactoryGirl.create(:membership, team: giraffes, account: current_account) }

  context "account can only see teams where they are a member or leader" do
    When { visit teams_path }

    Then { within("##{unicorns.dom_id}") { expect(page).to have_content(current_account.name) } }
    Then { within("##{unicorns.dom_id}") { expect(page).to have_content(zee.name) } }

    Then { within("##{giraffes.dom_id}") { expect(page).to have_content(current_account.name) } }

    Then { expect(page).not_to have_selector("#{dinosaurs.dom_id}") }
  end
end
