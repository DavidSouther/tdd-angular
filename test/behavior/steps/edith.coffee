require "should"
World = require "../support/world"
module.exports = ->
	@Given /^Edith has her browser open$/, (callback) ->
		# The world loads a browser
		@world = new World()
		callback()

	@When /^Edith goes to the url directly$/, (callback) ->
		@world.visit "http://localhost:3000/", callback

	@Then /^she should see "([^"]*)" in the title$/, (title, callback) ->
		@world.title().indexOf(title).should.be.greaterThan -1,
			"'#{title}' expected in title"

		callback()
