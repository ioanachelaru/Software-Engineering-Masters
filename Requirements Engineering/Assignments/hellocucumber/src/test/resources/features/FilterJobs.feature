Feature: Filter job announcements

  Scenario: User wants to filter announcements by domain
    Given the user is any kind of user browsing the website
    And he or she browses to the page which displays announcements
    When the user selects one or more domains
    Then the displayed announcements should only have the selected domains
