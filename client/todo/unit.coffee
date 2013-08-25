describe "todo controller", ->
	beforeEach module "todo"

	$scope = null
	beforeEach inject ($rootScope, $controller)->
		$scope = $rootScope.$new()
		$controller "todo", {$scope}

	it "exposes todos", ->
		expect($scope.todos).toEqual([], "todos should be array")
		expect($scope.Todos).toBeDefined("Todos should be object")
		expect($scope.Todos.current).toBe("", "Todos should have current (empty) reference")
		expect(typeof $scope.Todos.add).toBe("function", "Todos.add should be function")

	it "can add todo", ->
		$scope.Todos.current = "Todo 1"
		$scope.Todos.add()
		expect($scope.todos.length).toEqual(1, "After adding, todos has single todo")
		expect($scope.todos[0]).toEqual("Todo 1", "Correct Todo was added")
		expect($scope.Todos.current).toEqual("", "Resets current todo")