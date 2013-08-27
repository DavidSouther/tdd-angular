Q = require 'q'
should = require "should"
World = require "../support/worlds"

module.exports = ->
	###
	Check for bootstap on the page...
	####
	@Then /^bootstrap is loaded$/, (done)->
		done() # No idea how to test this...

	###
	Verify an element is "centered"
	###
	@Then /the "([^"]+)" is centered/, (elem, done)->
		@world.coords(elem)
		.then (coords)->
			# The expected position is how far "left" the element should be
			# This is a numerically quick way to calculate
			expected = (coords.window.width - coords.element.width) / 2
			actual = coords.element.left
			absolute = Math.abs(actual - expected)
			# The tolerance for positioning is some percentage of the window width,
			# in this case 5%
			tolerance = 0.05 * coords.window.width
			# The error should be less than some tolerance
			absolute.should.be.lessThan tolerance, "centering #{elem}"
		.then(->done())
		.catch(done)

