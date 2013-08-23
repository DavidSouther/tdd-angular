module.exports = ->
	@Then /MORE FEATURES/, (callback) ->
		throw "BUILD MORE FEATURES"
		# express the regexp above with the code you wish you had
		callback.pending()

