Feature: Site looks nice
	As a user of our side
	Jason wants the site to be pleasant to use
	So that he has an exceptional experience

	Scenario: basic styling
		Given Jason has his browser open
		When he visits the site
		Then the "header" is centered
		And the "input" is centered
