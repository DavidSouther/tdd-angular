module.exports = todo = angular.module "todo", []

todo.service "storage", ->
	get: -> JSON.parse window.localStorage["TDD-ToDos"] || '[]'
	set: (TDs)-> window.localStorage["TDD-ToDos"] = JSON.stringify TDs

todo.controller "todo", ($scope, storage)->
	$scope.todos = storage.get()
	Todos = $scope.Todos =
		current: ""
		add: ->
			$scope.todos.push Todos.current
			Todos.current = ""
			storage.set $scope.todos
		remove: (todo)->
			$scope.todos.splice $scope.todos.indexOf(todo), 1
