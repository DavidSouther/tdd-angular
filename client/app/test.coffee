describe "todo bootstrap", ->
	beforeEach module "todo"

	$scope = null
	beforeEach inject ($rootScope, $controller)->
		$scope = $rootScope.$new()
		$controller "todo", {$scope}

	it "exposes todo lists", ->
		expect($scope.todos).toEqual([])
