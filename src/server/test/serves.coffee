should = require "should"
server = require "../server"
request = require "request"

get = (path, d, cb)->
	request path, (e, r, b)->
		cb e, r, b
		d()

index  = (d, cb)-> get "http://localhost:3000/", d, cb
bundle = (d, cb)-> get "http://localhost:3000/bundle.js", d, cb
styles = (d, cb)-> get "http://localhost:3000/page.css", d, cb

Callbacks =
	OK: (e, res)->
		res.statusCode.should.equal 200

describe "Server", ->

	before ->
		server.serve()

	describe "/", ->
		it "binds on a known port", (done)->
			index done, (err, response)->
				should.not.exist err, "Error when GETting (#{err})"

		it "returns 200 when requesting /", (done)->
			index done, Callbacks.OK

		it "returns an index page at /", (done)->
			index done, (e, r, body)->
				body.should.match /^<!DOCTYPE html><html>/
				body.should.match /<\/html>$/

	describe "index.html", ->
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
				matches = body.match /<input[^>]+placeholder="([^"]+)"/
				should.exist matches
				matches[1].should.match /to-do/

		it "sets a viewport", (done)->
			index done, (e, r, body)->
				body.should.match /<meta[^>]+name="viewport"/

		it "has a link in the footer", (done)->
			index done, (e, r, body)->
				body.should.match /<a[^>]+href="[^"]+davidsouther.com/

	describe "bundle.js", ->
		it "returns a bundle", (done)->
			bundle done, Callbacks.OK

		it "returns a js bundle", (done)->
			bundle done, (e, res)->
				res.headers["content-type"].should.equal "text/javascript"

		it "defines an Angular module", (done)->
			bundle done, (e, r, body)->
				body.should.match ///
					angular\.module\("todo"
				///

	describe "page.css", ->
		it "returns a stylesheet", (done)->
			styles done, Callbacks.OK

		it "returns a css bundle", (done)->
			styles done, (e, res)->
				res.headers["content-type"].should.equal "text/css"

	describe "bower", ->
		it "serves Bower resources", (done)->
			request "http://localhost:3000/bower/angular/angular.js", (e, res)->
				res.statusCode.should.equal 200
				done()
