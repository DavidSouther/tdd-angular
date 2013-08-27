path = require "path"
express = require "express"
app = express()

root = path.join __dirname, "..", ".."

app.get '/page.css', (req, res)->
	res.set "content-type", "text/css"
	res.sendfile path.join root, "build", "page.css"

app.get '/bundle.js', (req, res)->
	res.set "content-type", "text/javascript"
	res.sendfile path.join root, "build", "bundle.js"

app.get '/bower/:module/:file', (req, res)->
	res.set "content-type", "text/javascript"
	res.sendfile path.join root, "bower_components", req.params.module, req.params.file

app.get '/', (req, res)->
	res.sendfile path.join root, "build", "index.html"

module.exports =
	serve: ->
		app.listen(3000)
