Feature: Relaxation session
	As a registered user of the website
	I want to see all my relaxation session

		Scenario: I want to see my relaxation sessions
		Given I am logged in
			And I have a relaxation session
		When I check my relaxation session
		Then I should see the table heading
			And I should see my relaxation session device entry
			And I should see my relaxation session start time entry
			And I should see my relaxation session start date entry
			And I should see my relaxation session ending time entry
			And I should see my relaxation session ending date entry