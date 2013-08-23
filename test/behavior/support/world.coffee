Zombie = require "zombie"

module.exports = class World
	constructor: ->
		@browser = new Zombie()

	visit: (url, cb)->
		@browser.visit url, cb

	title: ->
		@browser.text "title"


