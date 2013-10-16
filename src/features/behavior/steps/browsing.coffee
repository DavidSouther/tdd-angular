Q = require 'q'
should = require "should"

module.exports = ->
	require('qcumber')(@)

	@Given /has (?:his|her|a) browser open$/, -> true

	@Given /has entered a "([^"]*)" item/, (value)->
		@world.visit("http://localhost:3000/")
		.then(=>@world.fill(value, value, true))

	@Given /(?:on|goes to|visits) the (?:site|landing page)(?: directly)?/, ->
		@world.visit("http://localhost:3000/")

	@When /goes to the "([^"]*)" url/, (url)->
		@world.visit("http://localhost:3000/")

	@Given /leaves the page/, ->
		@world.visit("http://localhost:3000/")

	@When /enters "([^"]+)" into (?:the|a) "([^"]+)" (?:box|input|field)/, (value, field)->
		@world.fill(field, value, true)

	@When /enters into (?:the|a) "([^"]+)" (?:box|input|field)/, (field, lines)->
		Q.all([@world.fill(field, line, true) for line in lines.split '\n'])

	###
	Check for existance of a string in the title
	###
	@Then /should see "([^"]*)" in (?:the )title$/, (what) ->
		@world.title()
		.then (text)->
			text.indexOf(what).should.be.greaterThan -1,
				"'#{what}' expected in title"

	###
	Check for existance of a string in a selector
	###
	@Then /should see "([^"]*)" in (?:the )"([^"]*)"$/, (what, where) ->
		@world.text(where)
		.then (text)->
			text.indexOf(what).should.be.greaterThan -1,
				"'#{what}' expected in '#{where}'"

	###
	Check for reasonable placeholder value
	###
	@Then /invited to enter a(?:nother)? "([^"]*)"/, (value)->
		@world.placeholder("input[type=text]")
		.then (placeholder)->
			placeholder.should.match ///#{value}///,
				"placeholder should be inviting."

	###
	Check for content somewhere in the body.
	###
	@Then /page shows "([^"]+)"/, (content)->
		@world.text("body")
		.then (text)->
			text.should.match ///#{content}///

	###
	Ensure lack of content in the body.
	###
	@Then /page does not show "([^"]+)"/, (content)->
		@world.text("body")
		.then (text)->
			text.should.not.match ///#{content}///
