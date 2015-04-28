require 'rails_helper'

feature 'Sign up' do
  given(:account) { FactoryGirl.create(:account) }

  scenario 'with valid name, email, password' do
    visit new_account_registration_path
    fill_in 'Name', with: 'Test Tester'
    fill_in 'Email', with: 'test@email.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content 'Welcome'
  end

end