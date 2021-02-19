Feature: Anonymous website user wants to register as user

  Scenario: User is a student
    Given the user is a student
    And he or she has a valid email address
    When user enters personal data
    Then the system should create an account for the given email
    And the account should be of type student
    And the user should receive a confirmation email
