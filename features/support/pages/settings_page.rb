# frozen_string_literal: true

# Represents the registration page
# for feature testing purposes
class SettingsPage < Page
  set_url "/accounts/edit"

  element :check_in_reminder_time_dropdown, "#account_check_in_reminder_time"
  element :current_password_field, "#account_current_password"
  element :submit_button, "form#edit_account input[type=submit]"
  element :flash_notice, ".flash_notice"

  def set_check_in_reminder_time(desired_time)
    check_in_reminder_time_dropdown.select(desired_time)
  end

  def selected_check_in_reminder_time
    check_in_reminder_time_dropdown.find_all("option").find(&:selected?).text
  end

  def available_check_in_reminder_times
    check_in_reminder_time_dropdown.find_all("option").map(&:text)
  end

  def save_settings(expect_success: true)
    submit_button.click
    flash_notice.text !~ /success/i && raise("save failed") if expect_success
    page.title =~ /Exception caught/ && raise(page.title)
  end
end
