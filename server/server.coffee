express = require "express"
app = express()
path = require "path"

app.get '/', (req, res)->
	res.sendfile path.join __dirname, "..", "client", "index.html"

module.exports =
	serve: ->
		app.listen(3000)