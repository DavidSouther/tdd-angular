Feature: Site is available
	As a user of our site
	Edith wants to see the site
	So that she knows it exists

	Scenario: Direct Browsing
		Given Edith has her browser open
		When she goes to the site directly
		Then she should see "Angular JS" in the title

Feature: Site loads
	As a fly-fishing enthusiest
	Edith wants the site to load
	So she can list her fly-fishing to-do list

	Scenario: Landing bootstrap
		Given Edith has her browser open
		When she goes to the landing page
		Then she should see "To Do" in the title
		And she should see "To Do" in the "header"
		And she should be invited to enter a "to-do" item

	Scenario: First to-do
		Given Edith is on the landing page
		When she enters "Buy peacock feathers" into the "to-do" box
		Then the page shows "Buy peacock feathers"

	Scenario: Second to-do
		Given Edith is on the landing page
		When she enters into a "to-do" box
			"""
			Buy peacock feathers
			Use peacock feathers to make a fly
			"""
		Then the page shows "Buy peacock feathers"
		And the page shows "Use peacock feathers to make a fly"
		And she should be invited to enter another "to-do" item

	@current
	Scenario: Finishes a todo
		Given Edith is on the landing page
		And she enters into a "to-do" box
			"""
			Buy peacock feathers
			Use peacock feathers to make a fly
			"""
		When she removes the first todo
		Then the page does not show "Buy peacock feathers"
		And the page shows "Use peacock feathers to make a fly"

Feature: Todo lists save
	As a user of our site
	Edith wants the site to save her list
	So that she can return to a list she made in the past

	Scenario: Saves list
		Given Edith is on the landing page
		And she enters into a "to-do" box
			"""
			Buy peacock feathers
			Use peacock feathers to make a fly
			"""
		And she leaves the page
		When she goes to the "saved" url
		Then the page shows "Buy peacock feathers"
		And the page shows "Use peacock feathers to make a fly"
		And she should be invited to enter another "to-do" item
		# Satisfied, she goes back to sleep

	Scenario: Saves list after completing
		Given Edith is on the landing page
		And she enters into a "to-do" box
			"""
			Buy peacock feathers
			Use peacock feathers to make a fly
			"""
		And she removes the first todo
		And she leaves the page
		When she goes to the "saved" url
		Then the page does not show "Buy peacock feathers"
		And the page shows "Use peacock feathers to make a fly"
