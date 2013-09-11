module.exports = todo = angular.module "todo", ['ngAnimate']

todo.service "storage", ->
	runtime = new JEFRi.Runtime "/context.json"

	get: -> JSON.parse window.localStorage["TDD-ToDos"] || '[]'
	put: (TDs)-> window.localStorage["TDD-ToDos"] = JSON.stringify TDs || []

todo.controller "todo", ($scope, storage)->
	$scope.todos = storage.get()
	save = (newV, oldV) ->
		storage.put $scope.todos
	$scope.$watch 'todos', save, true
	Todos = $scope.Todos =
		current: ""
		add: ->
			$scope.todos.push Todos.current
			Todos.current = ""
		remove: (todo)->
			$scope.todos.splice $scope.todos.indexOf(todo), 1
