Feature: Add a note with a snippet
  As a programmer
  I want to add a note
  So I can quickly find them in the future


  Scenario: Add a snippet 
    Given I am on the notes page
    And I enter a new note
    Then I should see "New snippet added!"
