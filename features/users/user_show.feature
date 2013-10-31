Feature: View profile
  As a registered user to the website
  I want to see my profile

    Scenario: Viewing users
      Given I exist as a user
      	And I am logged in
      When I look at my profile
      Then I should see my username
