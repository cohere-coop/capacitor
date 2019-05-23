Feature: Logging Time

Scenario: logging time in the future
    Given I am on the Check In page
    When I perform checkin with a date in the future
    Then I am told that my checkin date must not be in the future
    And I remain on the Check In page

Scenario: logging time in increments greater than one day
    Given I am on the Check In page
    When I perform checkin with a work duration 10~12 hours 
    And I go to the Logs page
    Then I see 10~12 hours for that log entry