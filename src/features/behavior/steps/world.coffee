World = require "../support/worlds"
module.exports = ->
	require('qcumber')(@)

	@Before (done)=>
		# opening a browser is like entering a whole new world...
		@world = World.get()
		done()

	@After (done)=>
		@world?.destroy().then(done)
