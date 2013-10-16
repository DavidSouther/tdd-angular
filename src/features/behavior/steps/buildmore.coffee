module.exports = ->
	require('qcumber')(@)

	@Then /MORE FEATURES/, ->
		throw "BUILD MORE FEATURES"
