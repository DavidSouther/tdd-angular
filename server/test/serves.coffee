should = require "should"
server = require "../server"
request = require "request"
describe "Server", ->
	index = (d, cb)->
		request "http://localhost:3000/", (e, r, b)->
			cb e, r, b
			d()

	before ->
		server.serve()

	it "binds on a known port", (done)->
		index done, (err, response)->
			should.not.exist err, "Error when GETting (#{err})"

	it "returns 200 when requesting /", (done)->
		index done, (e, res)->
			res.statusCode.should.equal 200

	it "returns an index page at /", (done)->
		index done, (e, r, body)->
			body.should.match /^<html>/
			body.should.match /<\/html>$/

	it "returns a page with a title", (done)->
		index done, (e, r, body)->
			body.should.match ///
					<title>[^<]*Angular\sJS[^<]*</title>
				///,
				"page needs a title"

	it "returns a page with a header", (done)->
		index done, (e, r, body)->
			body.should.match /<header>/
			body.should.match /<\/header>/

	it "returns a page with input fields", (done)->
		index done, (e, r, body)->
			body.should.match /<input[^>]*>/

	it "sets the placeholder on the input", (done)->
		index done, (e, r, body)->
			matches = body.match /<input[^>]+placeholder="([^"]+)"[^>]+\/>/
			should.exist matches
			matches[1].should.match /to-do/