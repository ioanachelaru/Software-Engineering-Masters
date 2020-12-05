Feature: Posting new job announcements

  Scenario: Recruiter posts new job announcement
    Given the user is a recruiter
    And he or she is logged in with a confirmed account
    And he or she browses to add new announcement page
    When user enters domain and job description
    Then the system should create a new announcement
    And the recruiter that created it should be an administrator with full rights
