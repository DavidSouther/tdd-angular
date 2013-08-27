World = require "./worlds/protractor"
# module.exports = require "./worlds/zombie"
world = new World()
module.exports =
	get: ->
		if world.isDestroyed()
			world = new World()
		return world
