App.controller 'StacksCtrl', ['$scope', 'Stacks', ($scope, Stacks) ->

	partition = (array, numPartitions) ->
		result = []
		size = numPartitions
		while (array.length > 0)
			result.push(array.splice(0,size))
		result

	$scope.numPartitions = 4

	Stacks.query((response) ->
		# partition indicates the number of stacks to display per row
		$scope.splitStacks = partition(response.splice(0,8), $scope.numPartitions)
	)

]