# frozen_string_literal: true

Given(/^I am on the (.*) page$/) do |page_name|
  app.visit_page(page_name)
end

When(/^I perform (\w+) with a (.*)$/) do |action, params|
  app.current_page.perform(action, params)
end

Then(/^I am taken to the (.*) page$/) do |page_name|
  expect(app.page(page_name)).to be_displayed
end

Then(/^I am told that my checkin date must not be in the future$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I remain on the Check In page$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I go to the Logs page$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I see (\d+)~(\d+) hours for that log entry$/) do |arg1, arg2|
  pending # Write code here that turns the phrase above into concrete actions
end
