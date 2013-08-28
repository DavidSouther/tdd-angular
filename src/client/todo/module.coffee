module.exports = todo = angular.module "todo", []

todo.service "storage", ->
	get: -> JSON.parse window.localStorage["TDD-ToDos"] || '[]'
	put: (TDs)-> window.localStorage["TDD-ToDos"] = JSON.stringify TDs

todo.controller "todo", ($scope, storage)->
	todos = $scope.todos = storage.get()
	save = (newV, oldV) ->
		storage.put todos
	$scope.$watch 'todos', save, true
	Todos = $scope.Todos =
		current: ""
		add: ->
			todos.push Todos.current
			Todos.current = ""
		remove: (todo)->
			todos.splice todos.indexOf(todo), 1
