Feature: Edith
	As a user of our site
	Edith wants to see the site
	So that she knows it exists

	Scenario: Direct Browsing
		Given Edith has her browser open
		When she goes to the site directly
		Then she should see "Angular JS" in the title

	Scenario: More Features!
		Given Edith has her browser open
		When she goes to the site
		Then she wants MORE FEATURES!