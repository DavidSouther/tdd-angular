path = require "path"
express = require "express"
app = express()

app.get '/bundle.js', (req, res)->
	res.set "content-type", "text/javascript"
	res.sendfile path.join __dirname, "..", "client", "bundle.js"

app.get '/bower/:module/:file', (req, res)->
	res.set "content-type", "text/javascript"
	res.sendfile path.join __dirname, "..", "bower_components", req.params.module, req.params.file	

app.get '/', (req, res)->
	res.sendfile path.join __dirname, "..", "client", "index.html"

module.exports =
	serve: ->
		app.listen(3000)
