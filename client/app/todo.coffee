module.exports = todo = angular.module "todo", []

angular.module("todo")
.controller "todo", ($scope)->
	$scope.todos = []
