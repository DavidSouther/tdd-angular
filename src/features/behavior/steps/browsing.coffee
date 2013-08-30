Q = require 'q'
should = require "should"

server = process.env.SERVER || "http://localhost:3000/"

module.exports = ->
	@Given /has (?:his|her|a) browser open$/, (done)->
		done()

	@Given /has entered a "([^"]*)" item/, (value, done)->
		@world.visit(server)
		.then(=>@world.fill(value, value, true))
		.then(=>done())
		.catch(done)

	@Given /(?:on|goes to|visits) the (?:site|landing page)(?: directly)?/, (done)->
		@world.visit(server)
		.then(done)

	@When /goes to the "([^"]*)" url/, (url, done)->
		@world.visit(server)
		.then(done)

	@Given /leaves the page/, (done)->
		# @world.reload()
		@world.visit(server)
		.then ->done()

	@When /enters "([^"]+)" into (?:the|a) "([^"]+)" (?:box|input|field)/, (value, field, done)->
		@world.fill(field, value, true)
		.then(->done())
		.catch(done)

	@When /enters into (?:the|a) "([^"]+)" (?:box|input|field)/, (field, lines, done)->
		Q.all([@world.fill(field, line, true) for line in lines.split '\n'])
		.then(->done())
		.catch(done)

	###
	Check for existance of a string in the title
	###
	@Then /should see "([^"]*)" in (?:the )title$/, (what, done) ->
		@world.title()
		.then (text)->
			text.indexOf(what).should.be.greaterThan -1,
				"'#{what}' expected in title"
			done()
		.catch done

	###
	Check for existance of a string in a selector
	###
	@Then /should see "([^"]*)" in (?:the )"([^"]*)"$/, (what, where, done) ->
		@world.text(where)
		.then (text)->
			text.indexOf(what).should.be.greaterThan -1,
				"'#{what}' expected in '#{where}'"
			done()
		.catch done 

	###
	Check for reasonable placeholder value
	###
	@Then /invited to enter a(?:nother)? "([^"]*)"/, (value, done)->
		@world.placeholder("input[type=text]")
		.then (placeholder)->
			placeholder.should.match ///#{value}///,
				"placeholder should be inviting."
			done()
		.catch done

	###
	Check for content somewhere in the body.
	###
	@Then /page shows "([^"]+)"/, (content, done)->
		@world.text("body")
		.then (text)->
			text.should.match ///#{content}///
			done()
		.catch done

	###
	Ensure lack of content in the body.
	###
	@Then /page does not show "([^"]+)"/, (content, done)->
		@world.text("body")
		.then (text)->
			text.should.not.match ///#{content}///
			done()
		.catch done
