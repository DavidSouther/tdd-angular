angular.module('todo').service "storage", ($location, $q)->
	todos = null

	base = "#{$location.protocol()}://#{$location.host()}:#{$location.port()}/"
	runtime = new JEFRi.Runtime "#{base}context.json"
	loading = $q.defer()

	storage =
		get: ->
		save: ->
		runtime: runtime
		ready: loading.promise

	runtime.ready.then ->
		# TODO replace with loading todos list

		todos = runtime.build "List"
		storage.get = -> todos
		storage.save = ->
			t = new window.JEFRi.Transaction()
			t.add todos
			t.add todo for todo in todos.todos
			s = new window.JEFRi.Stores.PostStore({remote: base, runtime})
			s.execute 'persist', t
		loading.resolve todos
	.catch ->
		console.error "Couldn't load context!"
	storage
