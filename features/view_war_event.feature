Feature: View a war event on the front page
  In order to learn about an event in the war
  As an investigator
  I want to see the details of an event

  Scenario: Updating the name of a language
    Given a war event exists with type_of_event: "Enemy Action", summary: "The individual was also tactical questioned and enrolled into HIDES.", date: "2004-01-06"
    When I go to the home page
    Then I should see "Enemy Action"
    When I follow "Show"
    Then I should see "The individual was also tactical questioned and enrolled into HIDES."
