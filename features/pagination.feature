Feature: pagination
  In order to navigate through many war event
  As an investigator
  I want to be able to view different pages and keep track of where I was

  Background:
    Given 64 war events exist numbered with the category "war event #n"

  Scenario: A page has 30 events
    When I go to the home page
    And I follow "2"
    Then I should not see "war event 30"
    And I should see "war event 31"
    And I should see "war event 60"
    And I should not see "war event 61"

  @wip
  Scenario: Viewing multiple events on page 2
    When I go to the home page
    And I follow "2"
    And I follow "Show"
    And I follow "Back"
    Then I should see "war event 31"
