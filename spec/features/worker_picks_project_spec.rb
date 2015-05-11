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

  When { select("1 half-day", from: "Amount") }
  When { select("4", from: "Quality") }
  When { fill_in("Worked at", with: "2015-05-06") }
  When { check( "Do Not Bill")}
  When { click_link_or_button "Log Capacity" }
  Then { expect(Capacity.find_by(worker: current_account, amount: 4, quality: 4, worked_at: "2015-05-06", do_not_bill: false, project: project_to_work_on)).to be_present }

end