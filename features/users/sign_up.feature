Feature: Sign up
  In order to get access to protected sections of the site
  As a user
  I want to be able to sign up

    Background:
      Given I am not logged in

    Scenario: User signs up with valid data
      When I sign up with valid user data
      Then I should see a successful sign up message
     
      
    Scenario: User signs up with invalid email
      When I sign up with an invalid email
      Then I should see an invalid email message 

    Scenario: User signs up without email
      When I sign up with a blank email
      Then I should see a blank email message

    Scenario: User signs up without username
      When I sign up with a blank username
      Then I should see a blank username message

    Scenario: User signs up with invalid username
      When I sign up with an invalid username
      Then I should see an invalid username message

    Scenario: User signs up with too short username
      When I sign up with username that is too short
      Then I should see a short username message

    Scenario: User signs up without password
      When I sign up without a password
      Then I should see a missing password message

    Scenario: User signs up with too short password
      When I sign up with a password that is too short
      Then I should see a short password message
      

    Scenario: User signs up without password confirmation
      When I sign up without a password confirmation
      Then I should see a missing password confirmation message
      
    Scenario: User signs up with mismatched password and confirmation
      When I sign up with a mismatched password confirmation
      Then I should see a mismatched password message

    Scenario: User signs up without firstname
      When I sign up without a firstname
      Then I should see a missing firstname message
    
    Scenario: User signs up with an invalid firstname
      When I sign up with an invalid firstname
      Then I should see an invalid firstname message
       
    Scenario: User signs up without lastname
      When I sign up without a lastname
      Then I should see a missing lastname message
    
    Scenario: User signs up with an invalid lastname
      When I sign up with an invalid lastname
      Then I should see an invalid lastname message

    Scenario: User signs up without year of birth
      When I sign up without year of birth
      Then I should see a blank year of birth message

    Scenario: User signs up without gender
      When I sign up without gender
      Then I should see a blank gender message

    Scenario: User signs up without accepting terms of use and privacy policy
      When I sign up without accepting terms of use and privacy policy
      Then I should see a blank terms and policy message

    