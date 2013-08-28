path = require "path"
root = path.join __dirname, "..", ".."

nconf = require "nconf"
nconf.argv()
	.env()
	.file
		file: path.join root, 'server.json'
	.defaults
		port: 3000

express = require "express"
app = express()
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

module.exports = do ->
	serve: ->
		port = nconf.get('port')
		server = app.listen port
		console.log "ToDo Application Server listening on port #{port}"
	stop: ->
		server?.close()
