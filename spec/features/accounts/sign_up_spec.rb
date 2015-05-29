require "rails_helper"

feature "Sign up" do
  scenario "with valid name, email, password" do
    visit new_account_registration_path
    fill_in "Name", with: "Test Tester"
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"
    expect(Account.find_by(email: "test@example.com")).to be_present
    expect(current_path).to eql "/"
  end
end
