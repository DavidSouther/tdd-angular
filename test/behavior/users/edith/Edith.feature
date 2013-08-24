Feature: Site is available
	As a user of our site
	Edith wants to see the site
	So that she knows it exists

	Scenario: Direct Browsing
		Given Edith has her browser open
		When she goes to the site directly
		Then she should see "Angular JS" in the "title"

Feature: Site loads
	As a fly-fishing enthusiest
	Edith wants the site to load
	So she can list her fly-fishing to-do list

	Scenario: Landing bootstrap
		Given Edith has her browser open
		When she goes to the landing page
		Then she should see "To Do" in the "title"
		And she should see "To Do" in the "header"
		And she should be invited to enter a "to-do" item

	Scenario: First to-do
		Given Edith is on the landing page
		When she enters "Buy peacock feathers" into a "text" box
		Then the page shows "1. Buy peackock feathres"

	# Scenario: Second to-do
	# 	Given Edith has entered a "to-do" item
	# 	And she is invited to enter a "to-do" item
	# 	When she enters "Use peacock feathers to make a fly" into a "text" box
	# 	Then the page shows "1. Buy peackock feathres"
	# 	And the page shows "2. Use peacock feathers to make a fly"
	# 	And she should be invited to enter another "to-do" item

	# # Edith wonders whether the site will remember her list. Then she sees
	# # that the site has generated a unique URL for her -- there is some
	# # explanatory text to that effect.
	# Scenario: Saves list
	# 	Given Edith has entered a "to-do" item
	# 	And she leaves the page
	# 	When she goes to the "saved" url
	# 	Then the page shows "1. Buy peackock feathres"
	# 	And the page shows "2. Use peacock feathers to make a fly"
	# 	And she should be invited to enter another "to-do" item
	# 	# Satisfied, she goes back to sleep

	Scenario: More Features!
		Given Edith has her browser open
		When she goes to the site
		Then she wants MORE FEATURES!
