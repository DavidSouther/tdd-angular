should = require "should"
server = require "../server"
request = require "request"

get = (path, d, cb)->
	request path, (e, r, b)->
		cb e, r, b
		d()



index  = (d, cb)-> get "http://localhost:#{port}/", d, cb
Callbacks =
	OK: (e, res)->
		res.statusCode.should.equal 200

describe "Server", ->
	_port = undefined

	before ->
		_port = nconf.get "port"
		nconf.set "PORT", 3030
		server.serve()

	after ->
		server.stop()
		nconf.set "PORT", _port
		_port = undefined

	describe "/", ->
		it "binds on a known port", (done)->
			index done, (err, response)->
				should.not.exist err, "Error when GETting (#{err})"
