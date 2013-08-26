Q = require "q"
should = require "should"
webdriver = require "selenium-webdriver"
Protractor = require "protractor"
By = Protractor.By

module.exports = class World
	constructor: ->
		@driver = new webdriver.Builder().
			usingServer('http://localhost:4444/wd/hub').
			withCapabilities(webdriver.Capabilities.firefox()).build();

		@driver.manage().timeouts().setScriptTimeout(10000);
		@ptor = Protractor.wrapDriver(@driver);

	visit: (url)->
		Q @ptor.get(url)

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
		if submit
			deferred.then ->
				input.submit()
		Q deferred

	destroy: (done)->
		@driver.quit()
