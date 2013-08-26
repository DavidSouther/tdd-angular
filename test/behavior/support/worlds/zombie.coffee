Zombie = require "zombie"

module.exports = class World
	constructor: ->
		@browser = new Zombie()

	visit: (url)->
		@browser.visit(url)

	find: (selector)->
		@browser.document.querySelectorAll selector

	text: (where)->
		@browser.text where

	fill: (what, value)->
		@browser.fill what, value

	submit: (fieldName)->
		field = @browser.document.querySelector "[name='#{fieldName}']"
		field.form.submit()
