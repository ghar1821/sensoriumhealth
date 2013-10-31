Feature: Admin sign in
  In order to get access to protected sections of the site
  An admin
  Should be able to sign in
       

    Scenario: Admin signs in successfully with email
      Given I exist as an admin
        And I am not logged in
      When I sign in with valid admin data
      Then I see a successful admin sign in message
        And I admin should be signed in

     Scenario: Admin signs in successfully with username
      Given I exist as an admin
        And I am not logged in
      When I sign in with valid admin username
      Then I see a successful admin sign in message
        And I admin should be signed in
       
    Scenario: Admin signs in unsuccessfully with invalid email
      Given I exist as an admin
        And I am not logged in
      When I sign in with an invalid admin email
      Then I see an invalid admin login message
       
    Scenario: Admin signs in unsuccessfully with invalid username
      Given I exist as an admin
        And I am not logged in
      When I sign in with an invalid admin username
      Then I see an invalid admin login message

    Scenario: Admin signs in unsuccessfully with invalid password
      Given I exist as an admin
        And I am not logged in
      When I sign in with an invalid admin password
      Then I see an invalid admin login message


    Scenario: Admin is not registered
      Given I do not exist as an admin
      When I sign in with valid admin data
      Then I see an invalid admin login message

    
      