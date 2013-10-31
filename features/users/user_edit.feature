Feature: Edit User
  As a registered user of the website
  I want to edit my user profile
  so I can change my username

    Scenario: I sign in and edit my account
      Given I am logged in
      When I edit my account details
      Then I should see an account edited message

    Scenario: I sign in and edit my account without filling in current password
    	Given I am logged in
    	When I edit my account details without filling in current password
    	Then I should see edit profile blank current password message

     Scenario: I sign in and edit my account with wrong current password
    	Given I am logged in
    	When I edit my account details with wrong current password
    	Then I should see edit profile invalid current password message

    Scenario: I sign in and edit my account details with mismatched password
    	Given I am logged in
    	When I edit my account details with mismatched password
    	Then I should see edit profile password mismatched message

    Scenario: I sign in and cancel my account
    	Given I am logged in
    	When I cancel my account
    	Then I should see a successful cancel account message
