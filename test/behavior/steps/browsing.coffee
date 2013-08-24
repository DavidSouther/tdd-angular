should = require "should"
World = require "../support/world"
module.exports = ->
	@Given /has (?:his|her|a) browser open$/, (cb)->
		# opening a browser is like entering a whole new world...
		@world = new World()
		cb()

	@Given /on the landing page/, (cb)->
		@world = new World()
		@world.visit("http://localhost:3000/")
		.then cb

	@When /goes to the (?:site|landing page)(?: directly)?/, (callback) ->
		@world.visit("http://localhost:3000/")
		.then callback

	@When /enters "([^"]+)" into the "([^"]+)" (?:box|input|field)/, (value, field, cb)->
		@world.fill(field, value)
		cb()

	###
	Check for existance of a string in a selector
	###
	@Then /should see "([^"]*)" in (?:the )"([^"]*)"$/, (what, where, callback) ->
		@world.text(where).indexOf(what).should.be.greaterThan -1,
			"'#{what}' expected in '#{where}'"
		callback()

	@Then /invited to enter a "([^"]*)"/, (value, callback)->
		inputs = @world.find("input[type=text]")
		inputs.length.should.equal 1,
			"One text input must exist."
		placeholder = inputs[0].getAttribute('placeholder')
		should.exist placeholder,
			"Input should have placeholder."
		placeholder.should.match ///#{value}///,
			"Placeholder should be inviting."
		callback()

	@Then /page shows "([^"]+)"/, (content)->
		text = @world.text("body")
		text.should.match ///#{content}///
