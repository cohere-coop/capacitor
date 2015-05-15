require 'rails_helper'

feature 'Update project capacities' do
  Given!(:current_account) { FactoryGirl.create(:account) }
  Given!(:project_to_work_on) { FactoryGirl.create(:project) }
  Given!(:project_not_to_work_on) { FactoryGirl.create(:project) }
  # TODO extract this to a helper
  When { visit new_account_session_path
    fill_in 'Email', with: current_account.email
    fill_in 'Password', with: current_account.password
    click_button 'Log in'}

  When { click_link_or_button project_to_work_on.name }

  When { select("1 half-day", from: "Amount") }
  When { select("4", from: "Quality") }
  When { fill_in("Worked at", with: "2015-05-06") }

  When { click_link_or_button "Log Capacity" }
  # TODO Need to create model test for update capacity method
  Then { expect(Project.find_by(name: project_to_work_on.name, total_capacity_owed: 15, capacity_used: 4, capacity_remaining: 11)).to be_present }


end
