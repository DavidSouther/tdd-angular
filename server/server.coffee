express = require "express"
app = express()

app.get '/', (req, res)->
	res.send "200", "<html><title>Angular JS</title></html>"

module.exports =
	serve: ->
		app.listen(3000)