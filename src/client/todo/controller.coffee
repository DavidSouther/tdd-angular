angular.module('todo').controller "todo", ($scope, storage)->
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
