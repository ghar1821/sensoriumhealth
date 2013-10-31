Feature: Leaderboard
	As a registered user of the website
	I want to see the leaderboard

		Scenario: I sign in and check out the leaderboard
			Given I am logged in
			When I look at the leaderboard
			Then I should see the leaderboard heading
				And I should see my username table entry
				And I should see the longest time in resonance heading
				And I should see the entry is 00:00:00