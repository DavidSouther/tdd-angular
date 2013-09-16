angular.module('todo').service "storage", ($location, $q)->
	todos = null
	base = "#{$location.protocol()}://#{$location.host()}:#{$location.port()}"
	runtime = new JEFRi.Runtime "#{base}/context.json"
	store = new JEFRi.Stores.PostStore base
	loading = $q.defer()
	storage =
		get: -> loading
		save: ->
	runtime.ready.then ->
		# TODO replace with loading todos list
		todos = runtime.build "List"
		storage.get = -> todos
		storage.save = -> runtime.save_all store
		loading.resolve todos
	storage
