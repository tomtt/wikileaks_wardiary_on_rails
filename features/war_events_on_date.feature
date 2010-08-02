Feature: View a list of war events on a given day
  In order to see all events on a given day
  As an investigator
  I want to narrow down results to only those on the day I am interested in

  Scenario: Viewing events by date
    Given a war event exists with summary: "On Monday I had some meatballs", date: "2004-01-05"
    Given a war event exists with summary: "On Tuesday I had some sausages", date: "2004-01-06"
    Given a war event exists with summary: "On Tuesday I had some potatoes", date: "2004-01-06"
    Given a war event exists with summary: "On Wednesday I had some spaghetti", date: "2004-01-07"
    When I go to the url "/dates/2004-01-06"
    Then I should see "On Tuesday I had some sausages"
    Then I should see "On Tuesday I had some potatoes"
