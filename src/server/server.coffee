path = require "path"
root = path.join __dirname, "..", ".."

nconf = require "nconf"
nconf.argv()
	.env()
	.file
		file: path.join root, 'server.json'
	.defaults
		PORT: 3000

express = require "express"
app =
	express()
		.get '/page.css', (req, res)->
			res.set "content-type", "text/css"
			res.sendfile path.join root, "build", "page.css"

		.get '/fonts/:font', (req, res)->
			res.sendfile path.join root, "bower_components", "bootstrap", "fonts", req.params.font

		.get '/bundle.js', (req, res)->
			res.set "content-type", "text/javascript"
			res.sendfile path.join root, "build", "bundle.js"

		.get '/context.json', (req, res)->
			res.set "content-type", "application/json"
			res.sendfile path.join root, "build", "context.json"

		.get '/bower/:module/:file', (req, res)->
			res.set "content-type", "text/javascript"
			res.sendfile path.join root, "bower_components", req.params.module, req.params.file

		.get '/', (req, res)->
			res.sendfile path.join root, "build", "index.html"

module.exports = do ->
	server = null
	serve: ->
		port = nconf.get('PORT')
		server = app.listen port
		console.log "ToDo Application Server listening on port #{port}"
	stop: ->
		server?.close()
