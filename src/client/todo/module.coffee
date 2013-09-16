module.exports = todo = angular.module "todo", ['ngAnimate']

todo.service "storage", ($location, $q)->
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

todo.controller "todo", ($scope, storage)->
	$scope.todos = storage.get()
	save = (newV, oldV) ->
		storage.save()
	$scope.$watch 'todos', save, true
	Todos = $scope.Todos =
		current: ""
		add: ->
			$scope.todos.push Todos.current
			Todos.current = ""
		remove: (todo)->
			$scope.todos.splice $scope.todos.indexOf(todo), 1
