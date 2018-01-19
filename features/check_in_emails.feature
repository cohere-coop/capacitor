Feature: Check-in reminder emails

  Scenario: User can schedule check-in reminders
    Given I am a worker
    When I set my check-in reminder time to 6:00PM
    And I miss a check-in
    And enough time passes that I should receive an email
    Then I should get an email reminder at 6:00PM-ish
