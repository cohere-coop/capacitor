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
