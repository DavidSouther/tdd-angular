require "should"
World = require "../support/world"
module.exports = ->
	@Given /has (?:his|her|a) browser open$/, (cb)->
		# opening a browser is like entering a whole new world...
		@world = new World()
		cb()

	@When /goes to the site(?: directly)?$/, (callback) ->
		@world.visit "http://localhost:3000/", callback

	@Then /should see "([^"]*)" in the title$/, (title, callback) ->
		@world.title().indexOf(title).should.be.greaterThan -1,
			"'#{title}' expected in title"

		callback()
