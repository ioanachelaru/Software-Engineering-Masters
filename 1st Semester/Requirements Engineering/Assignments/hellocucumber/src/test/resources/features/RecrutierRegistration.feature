Feature: Anonymous website user wants to register as recruiter

  Scenario: User is a recruiting representative
    Given the user is a recruiting representative
    And he or she has a valid email address
    When users browses to register HR or company
    And enters personal or company data
    Then the system should create an account for the given email
    And the account should be of type recruiter
    And the user should receive a confirmation email
