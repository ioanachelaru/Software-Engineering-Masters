Feature: Cancel applications

  Scenario: Student wants to cancel an ongoing application
    Given the user is a student
    And he or she has an ongoing application having any status
    When user selects Delete in the details page of the application
    Then the system should set the status of the application to cancelled by student
    And the recruiter should not be able to open the application anymore