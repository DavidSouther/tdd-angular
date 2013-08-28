Q = require 'q'
should = require "should"
module.exports = ->
	@When /remove(?:s?) the first todo/, (done)->
		@world.click(".remove:nth-of-type(1)")
		.then -> done()
		.catch done
