Zombie = require "zombie"

class World
	constructor: ->
		@browser = new Zombie()
		@

	visit: (url, cb)->
		@browser.visit url, cb

	title: ->
		@browser.text "title"

module.exports = World
