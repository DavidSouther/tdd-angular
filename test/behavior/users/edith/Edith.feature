Feature: Edith
	As a user of our site
	Edith wants to see the site
	So that she knows it exists

	Scenario: Direct Browsing
		Given Edith has her browser open
		When Edith goes to the url directly
		Then she should see "Angular JS" in the title