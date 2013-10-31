Feature: Admin send email
	An admin should be able to send email to all user
       

    Scenario: Admin visit send email page
      Given I exist as an admin
        And I am logged in as admin
      When I visit send email link
      Then I see message box

    Scenario: Admin wants to send email to all users
    	Given I exist as an admin
    		And I am logged in as admin
    	When I visit send email link
    		And I send email to all users
    	Then I see email sent confirmation
    		And it should send user a "notification" e-mail
      