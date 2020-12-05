Feature: Plan a meeting with a student

  Scenario: Recruiter wants to plan a meeting with a student
    Given the user is a recruiter
    And the student has an open application for an announcement that has the recruiter as admin
    And the recruiter browses on the application page
    When user selected an empty timeframe in the calendar
    Then the system should register a meeting having the recruiter and the student as attendees
    And the student should receive a notification
