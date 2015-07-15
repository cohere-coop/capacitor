require "rails_helper"

feature "Viewing teams" do
  include_context "account login"

  Given!(:unicorns) { FactoryGirl.create(:team, name: "Unicorns").decorate }
  Given!(:zee) { FactoryGirl.create(:account, name: "Zee Spencer") }
  Given { unicorns.add_member(zee) }
  Given { unicorns.add_leader(current_account) }

  Given!(:dinosaurs) { FactoryGirl.create(:team, name: "Dinosaurs").decorate }

  Given!(:giraffes) { FactoryGirl.create(:team, name: "Giraffes").decorate }
  Given { giraffes.add_member(current_account) }

  context "account can only see teams where they are a member or leader" do
    When { visit teams_path }

    Then { within("##{unicorns.dom_id}") { expect(page).to have_content(current_account.name) } }
    Then { within("##{unicorns.dom_id}") { expect(page).to have_content(zee.name) } }

    Then { within("##{giraffes.dom_id}") { expect(page).to have_content(current_account.name) } }

    Then { expect(page).not_to have_selector("#{dinosaurs.dom_id}") }
  end
end
