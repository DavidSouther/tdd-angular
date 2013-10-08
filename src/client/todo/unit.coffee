$scope = null
loadScope = inject ($rootScope, $controller)->
	$scope = $rootScope.$new()
	$controller "todo", {$scope}


describe "todo controller", ->
	store = storage = undefined

	beforeEach angular.mocks.module "todo"
	beforeEach ->
		angular.module("todo").service "storage", ->
			storage = do ->
				store = {todos: []}
				get: -> store
				save: (TDs)->
					store = TDs || store
					{then: (cb)-> cb()}
				ready:
					then: (cb)-> cb(store)
				runtime:
					build: (type, vals)->
						vals.list = store
						vals._destroy = SPY.CREATE()
						store.todos.push vals
						vals

	beforeEach loadScope
	afterEach -> delete window.localStorage['TDD-ToDos']

	it "exposes todos", ->
		expect($scope.list.todos).toEqual([], "list should be array")
		expect($scope.Todos).toBeDefined("Todos should be object")
		expect($scope.Todos.current).toBe("", "Todos should have current (empty) reference")
		expect(typeof $scope.Todos.add).toBe("function", "Todos.add should be function")

	it "can add todo", ->
		$scope.Todos.current = "Todo 1"
		$scope.Todos.add()
		$scope.$digest()

		expect($scope.list.todos.length).toEqual(1, "After adding, list has single todo")
		expect($scope.list.todos[0].todo).toEqual("Todo 1", "Correct Todo was added")
		expect($scope.Todos.current).toEqual("", "Resets current todo")

	it "can remove todo", ->
		store.todos.remove = ->
			store.todos = store.todos[1..]

		$scope.Todos.current = "Todo 1"
		$scope.Todos.add()
		$scope.Todos.current = "Todo 2"
		$scope.Todos.add()
		$scope.$digest()

		todo = store.todos[0]
		$scope.Todos.remove(store.todos[0])

		expect($scope.list.todos.length).toEqual(1, "One todo left.")
		expect(todo._destroy.CALL_COUNT).toEqual(1, "_destroy spy called once.")
