Q = require 'q'
should = require "should"
module.exports = ->
	@When /remove(?:s?) the first todo/, (what, done)->
		@world.click(".remove:nth-of-type(1)")
		.then ->
			debugger;
			done()
		# .catch (e)->
		# 	done(e)
