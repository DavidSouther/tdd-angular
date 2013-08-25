module.exports = todo = angular.module "todo", []

todo.controller "todo", ($scope)->
	$scope.todos = []
	Todos = $scope.Todos =
		current: ""
		add: ->
			$scope.todos.push Todos.current
			Todos.current = ""
