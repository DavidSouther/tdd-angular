angular.module('todo').controller "todo", ($scope, storage)->
	watchExp = (entity)->
		lastModified = 0
		entity.on 'modified', ->
			lastModified = new Date / 1e3
		-> lastModified

	save = (newV, oldV) ->
		storage.save()
	storage.ready.then (list)->
		$scope.list = list
		# $scope.$watch watchExp(list), save, true
		$scope.$watch "list._modified._count", save, true

	Todos = $scope.Todos =
		current: ""
		add: ->
			todo = storage.runtime.build "Todo", {todo: Todos.current}
			todo.list = $scope.list
			Todos.current = ""
		remove: (todo)->
			todo._destroy()
