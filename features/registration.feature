Feature: Registration

  Scenario: Creating a new account with a unique email address
    Given I am on the registration page
    When I perform register with a unique account
    Then I receive a registration welcome email
    And I am taken to the home page
