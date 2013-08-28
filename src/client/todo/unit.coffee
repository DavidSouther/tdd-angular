$scope = null
loadScope = inject ($rootScope, $controller)->
	$scope = $rootScope.$new()
	$controller "todo", {$scope}

describe "todo controller", ->
	beforeEach module "todo"
	beforeEach loadScope
	afterEach -> delete window.localStorage['TDD-ToDos']

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

	it "can remove todo", ->
		$scope.Todos.current = "Todo 1"
		$scope.Todos.add()
		$scope.Todos.current = "Todo 2"
		$scope.Todos.add()
		$scope.Todos.remove("Todo 1")
		expect($scope.todos).toEqual(["Todo 2"], "One todo left.")

	describe "localStorage", ->
		it "saves to local storage", ->
			$scope.Todos.current = "Todo 1"
			$scope.Todos.add()
			expect(window.localStorage['TDD-ToDos']).toBeDefined("TDD-ToDos were created on localStorage")
			stored = window.localStorage['TDD-ToDos']
			expect(stored).toEqual('["Todo 1"]', "Saves array of todos")

		describe "load", ->
			beforeEach ->
				window.localStorage['TDD-ToDos'] = '["Todo 1"]'
				loadScope()

			it "restores from local storage", ->
				expect($scope.todos).toEqual(["Todo 1"], "Loaded one saved todo")
