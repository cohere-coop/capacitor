# frozen_string_literal: true

Given(/^I am a worker$/) do
  app.visit_page("registration")
  app.current_page.perform("register", "unique worker")
end

When(/^I set my check\-in reminder time to ([\d\w:]+)$/) do |desired_time|
  app.visit_page("settings")
  unless app.current_page.available_check_in_reminder_times.length > 1
    raise "no meaningful choice of reminder times"
  end
  app.current_page.choose_check_in_reminder_time(desired_time)
  # TODO: When we have eliminated the UX issue of needing to supply
  # current password all over the place, this becomes unnecessary
  app.current_page.current_password_field.set(app.current_account.password)
  app.current_page.save_settings
  app.visit_page("settings")
  expect(app.current_page.selected_check_in_reminder_time).to eq(desired_time)
end

When(/^I miss a check\-in$/) do
  # no-op
end

When(/^enough time passes that I should receive an email$/) do
  app.current_account.capture_and_tag_emails(email_client: email_client, rake_run: "9:00AM") do
    # March 13th is a Tuesday. Nothing happens on Tuesdays. It ought to be boring.
    env = { "OVERRIDE_CURRENT_TIME" => "March 13 2018 9:00AM" }
    # TODO: we got confused here because we weren't logging enough
    # we have fixed the confusion but should also fix its root cause
    success = system(env, "bin/rake capacitor:notify_accounts_of_missing_checkins")
    raise "Rake task failed" unless success
  end

  app.current_account.capture_and_tag_emails(email_client: email_client, rake_run: "6:00PM") do
    # March 13th is a Tuesday. Nothing happens on Tuesdays. It ought to be boring.
    env = { "OVERRIDE_CURRENT_TIME" => "March 13 2018 6:00PM" }
    # TODO: we got confused here because we weren't logging enough
    # we have fixed the confusion but should also fix its root cause
    success = system(env, "bin/rake capacitor:notify_accounts_of_missing_checkins")
    raise "Rake task failed" unless success
  end
end

Then(/^I should get an email reminder at (.+?)\-ish$/) do |time_string|
  # TODO: we are pulling the 9:00 AM bit out of thin air and our knowledge of past steps
  # this probably indicates a structural problem that we should probably fix?
  emails_for_wrong_time = app.current_account.emails_tagged_with(rake_run: "9:00AM")
  expect(emails_for_wrong_time).to be_empty

  emails_for_time = app.current_account.emails_tagged_with(rake_run: time_string)
  expect(emails_for_time).to_not be_empty
  expect(emails_for_time).to include(a_hash_including(subject: "Let's check in your activities from March 13th, 2018"))
end
