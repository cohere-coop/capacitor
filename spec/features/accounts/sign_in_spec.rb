require 'rails_helper'

feature 'Signing in' do
  given(:account) { FactoryGirl.create(:account) }

  scenario 'Signing in with correct credentials' do
    visit new_account_session_path
    fill_in 'Email', with: account.email
    fill_in 'Password', with: account.password
    click_button 'Log in'
    expect(page).to have_content 'Welcome'
  end

end