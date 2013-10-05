angular.module('todo').controller "todo", ($scope, storage)->
	save = (newV, oldV) ->
		storage.save()

	storage.ready.then (list)->
		$scope.list = list
		$scope.$watch "list._modified._count", save, true

	Todos = $scope.Todos =
		current: ""
		add: ->
			todo = storage.runtime.build "Todo", {todo: Todos.current}
			todo.list = $scope.list
			Todos.current = ""
		remove: (todo)->
			# This does a little voodoo
			# Remove the todo from the list, incidentally unsetting todo's list_id
			$scope.list.todos.remove todo
			# Save the todo with no list_id, then destroy the todo.
			storage.save(todo).then -> todo._destroy()
