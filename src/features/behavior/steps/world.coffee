fs = require "fs"
rmrf = require "rimraf"
World = require "../support/worlds"
module.exports = ->
	@Before (done)->
		# opening a browser is like entering a whole new world...
		@world = World.get()
		rmrf ".jefri", ->
			fs.mkdir ".jefri", ->
				done()

	@After (done)->
		@world?.destroy()
		done()
