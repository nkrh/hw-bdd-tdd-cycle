Feature: create, read, update, and delete a movie
 
  I want basic movie manipulation

Background: movies have been added to database

  Given the following movies exist:
  | title                   | rating | release_date |
  | Aladdin                 | G      | 25-Nov-1992  |
  | The Terminator          | R      | 26-Oct-1984  |

Scenario: create a new movie
  Given I am on the create movie page
  When I fill in "movie[title]" with "Fury"
  And I select "PG" from "movie[rating]"
  And I select "2014" from "movie[release_date(1i)]"
  And I select "October" from "movie[release_date(2i)]"
  And I select "23" from "movie[release_date(3i)]"
  And I press "Save Changes"
  Then I should be on the home page
  And I should see "Fury"
  
Scenario: update a new movie
  Given I am on the edit page for "Aladdin"
  When I fill in "movie[title]" with "1001 Nights"
  And I press "Update Movie Info"
  Then I should be on the details page for "1001 Nights"
  And I should see "1001 Nights was successfully updated"
  
Scenario: delete a movie
  Given I am on the details page for "Aladdin"
  When  I press "Delete"
  Then I should be on the home page
  And I should see "Movie 'Aladdin' deleted"

Scenario: read a movie
  Given I am on the home page 
  When I follow "More about Aladdin"
  Then I should see "Details about Aladdin"
  And I should see "Released on: November 25, 1992"
  And I should see "Rating: G"