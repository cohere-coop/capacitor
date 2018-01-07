scenario: logging time in the future
    Given that I am on the Check In page
    When I select a day in the future from "what day is this for"
    Then I am prevented from submitting the form
    And I am told that the "what day is this for" field is invalid because the day is in the future

scenario: logging time in increments greater than one day
    Given that I am on the Check In page
    When I check in for 10~12 hours
    Then I go to the Logs page
    And I see 10~12 hours for that log entry