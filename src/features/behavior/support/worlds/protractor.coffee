Q = require "q"
should = require "should"
webdriver = require "selenium-webdriver"
Protractor = require "protractor"
By = Protractor.By

_destroyed = false
module.exports = class World
	constructor: (browser="firefox")->
		@driver = new webdriver.Builder().
			usingServer(process.env.SELENIUM_HUB).
			withCapabilities(webdriver.Capabilities[browser]()).build()

		@driver.manage().timeouts().setScriptTimeout(10000)
		@ptor = Protractor.wrapDriver(@driver)

	visit: (url)->
		Q @ptor.get(url)

	reload: ->
		Q @ptor.reload()

	find: (selector)->
		@ptor.findElement By.css selector

	text: (where)->
		Q @find(where).getText()

	title: ->
		Q @ptor.getTitle()

	placeholder: (where)->
		Q @find(where).getAttribute 'placeholder'

	fill: (what, value, submit = false)->
		input = @ptor.findElement(By.name(what))
		deferred = input.sendKeys(value)
		input.submit()  if submit
		Q deferred

	coords: (elem)->
		Q.all([
			@find('html').getSize()
			@find( elem ).getLocation()
			@find( elem ).getSize()
		]).spread (window, location, size)->
			coords =
				window: window
				element:
					width: size.width
					left: location.x

	click: (what)->
		Q @find(what).click()

	destroy: ->
		_destroyed = true
		@driver.quit()

	isDestroyed: -> _destroyed
