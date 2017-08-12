# frozen_string_literal: true

RSpec.shared_context "account login" do
  Given!(:current_account) { FactoryGirl.create(:account) }
  around do |example|
    Time.use_zone(current_account.time_zone) do
      example.run
    end
  end

  When do
    visit new_account_session_path
    fill_in "Email", with: current_account.email
    fill_in "Password", with: current_account.password
    click_button "Log in"
  end
end
