require 'rails_helper'

# feature "Accounts", :type => :feature do
#   pending "add some scenarios (or delete) #{__FILE__}"
# end

# describe "the signin process", :type => :feature do
#   before :each do
#     User.make(:email => 'user@example.com', :password => 'password')
#   end

#   it "signs me in" do
#     visit '/sessions/new'
#     within("#session") do
#       fill_in 'Email', :with => 'user@example.com'
#       fill_in 'Password', :with => 'password'
#     end
#     click_button 'Sign in'
#     expect(page).to have_content 'Success'
#   end
# end

feature "Signing in" do
  background do
    User.make(:email => 'dicko@me.com', :password => 'password')
  end

  scenario "Signing in with correct credentials" do
    visit '/sessions/new'
    within("#session") do
      fill_in 'Email', :with => 'dicko@me.com'
      fill_in 'Password', :with => 'password'
    end
    click_button 'Sign in'
    expect(page).to have_content 'Success'
  end

  given(:krystyna) { User.make(:email => 'krystyna@me.com', :password => 'password') }

  scenario "Signing in as another user" do
    visit '/sessions/new'
    within("#session") do
      fill_in 'Email', :with => krystyna.email
      fill_in 'Password', :with => krystyna.password
    end
    click_button 'Sign in'
    expect(page).to have_content 'Invalid email or password'
  end
end

# require 'spec_helper'
# require 'rails_helper'
#
# feature 'user can sign up' do
#   scenario 'with valid name, email and password' do
#     visit '/signup'
#     fill_in 'Name', with: 'Raj'
#     fill_in 'Email', with: 'raj@raj.com'
#     click_button 'Create User'
#
#     # save_and_open_page
#   end
# end
#
# feature 'user can log in' do
#   scenario 'with valid email and password' do
#     User.create!(name: "Miriam", email: "miriam2@me.com", password: "password", password_confirmation: "password")
#     visit '/login'
#     fill_in 'Email', with: 'miriam2@me.com'
#     fill_in 'Password', with: 'password'
#     click_button 'Log in'
#
#     # save_and_open_page
#   end
# end

