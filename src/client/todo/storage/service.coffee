angular.module('todo').service "storage", ($location, $q, $rootScope)->
	base = "#{$location.protocol()}://#{$location.host()}:#{$location.port()}/"
	runtime = new JEFRi.Runtime "#{base}context.json"
	loading = $q.defer()

	storage =
		get: ->
		save: (e = null)->
		runtime: runtime
		ready: loading.promise
		store: new window.JEFRi.Stores.PostStore({remote: base, runtime})

	###
	Return a new Transaction
	###
	prep = -> new window.JEFRi.Transaction()

	###
	Load the user's list from the data store.
	###
	loadList = ->
		t = prep()
		# Request all lists from the server
		t.add _type: 'List', 'todos': {}

		storage.store.execute('get', t)
		.then (list)->
			if list.entities.length
				runtime.find('List')[0]
			else
				throw new Exception "List not found"

		.catch (e)->
			console.warn e
			# Build a new list, since one wasn't found!
			runtime.build ('List')

		.then (todos)->
			# Allow saving!
			storage.save = (e = null)->
				t = prep()
				if e
					t.add e
				else
					t.add todos
					t.add todo for todo in todos.todos
				storage.store.execute 'persist', t
			todos

	contextError = (e)->
		console.error "Couldn't load context!"
		console.log e
		# Do something smart...
		# like tell the user there's been a data error
		# or fall back to local storage

	finishedLoading = (todos)->
		storage.get = -> todos
		loading.resolve todos # why doesn't resolving $q trigger a digest?
		$rootScope.$digest()

	###
	After the runtime has finished loading, get some data for it!
	###
	runtime.ready
	.then(loadList)
	.then(finishedLoading, contextError)

	storage
 