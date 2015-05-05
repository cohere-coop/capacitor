require 'rails_helper'

feature 'worker picks project' do
	Given!(:current_account) { FactoryGirl.create(:account) }
	Given!(:project_to_work_on) { FactoryGirl.create(:project) }
	Given!(:project_not_to_work_on) { FactoryGirl.create(:project) }
	# TODO extract this to a helper
	When { visit new_account_session_path
    fill_in 'Email', with: current_account.email
    fill_in 'Password', with: current_account.password
    click_button 'Log in'}

  When { click_link_or_button project_to_work_on.name }

  Then { expect(page).to have_content("Track Capacity For #{project_to_work_on.name}") }
    


	
end