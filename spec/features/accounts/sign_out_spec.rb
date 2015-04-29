require 'rails_helper'

feature 'Sign out' do
  given(:account) { FactoryGirl.create(:account) }

  scenario 'Successfully' do
    visit new_account_session_path
    fill_in 'Email', with: account.email
    fill_in 'Password', with: account.password
    click_button 'Log in'
    click_on 'Sign out'
    expect(page).to have_content 'Sign in' 
  end

end