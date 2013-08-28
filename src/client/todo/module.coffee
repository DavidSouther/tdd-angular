module.exports = todo = angular.module "todo", []

todo.service "storage", ->
	get: -> JSON.parse window.localStorage["TDD-ToDos"] || '[]'
	set: (TDs)-> window.localStorage["TDD-ToDos"] = JSON.stringify TDs

todo.controller "todo", ($scope, storage)->
	$scope.todos = storage.get()
	$scope.$watch 'todos', -> storage.set $scope.todos
	Todos = $scope.Todos =
		current: ""
		add: -> $scope.$apply ->
			$scope.todos.push Todos.current
			Todos.current = ""
		remove: (todo)-> $scope.$apply ->
			$scope.todos.splice $scope.todos.indexOf(todo), 1
