Q = require 'q'
should = require "should"
module.exports = ->
	require('qcumber')(@)

    @Given /has entered a "([^"]*)" item/, (value)->
        @world.visit("http://localhost:3000/")
        .then(=>@world.fill(value, value, true))

	@When /remove(?:s?) the first todo/, ->
		@world.click(".remove:nth-of-type(1)")
