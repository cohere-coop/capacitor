require 'rails_helper'

feature 'Signing in' do
  given(:user) { FactoryGirl.create(:user) }

  scenario 'Signing in with correct credentials' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_content 'Welcome'
  end

end