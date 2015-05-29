require "rails_helper"

feature "Sign in" do
  given(:account) { FactoryGirl.create(:account) }

  scenario "with correct credentials" do
    visit new_account_session_path
    fill_in "Email", with: account.email
    fill_in "Password", with: account.password
    click_button "Log in"
    expect(current_path).to eql "/"
  end

  scenario "with incorrect credentials" do
    visit new_account_session_path
    fill_in "Email", with: account.email
    fill_in "Password", with: "654321"
    click_button "Log in"
    expect(current_path).not_to eql "/"
    expect(page).to have_content "Sign in"
  end
end
