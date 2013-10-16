Q = require 'q'
should = require "should"
module.exports = ->
	require('qcumber')(@)

	@When /remove(?:s?) the first todo/, ->
		@world.click(".remove:nth-of-type(1)")
