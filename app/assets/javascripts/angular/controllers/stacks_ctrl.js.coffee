App.controller 'StacksCtrl', ['$scope', 'Stacks', ($scope, Stacks) ->

	partition = (array, numPartitions) ->
		result = []
		size = numPartitions
		while (array.length > 0)
			result.push(array.splice(0,size))
		result

	$scope.message = "Hello World"

	$scope.sideBarMessage = ""

	# TODO
	# Would prefer to not have the 5 hardcoded
	# and also would be better to divorce the view
	# from the controller, which isn't currently the
	# case (5 & col-md-2)
	Stacks.query((response) ->
		$scope.split_stacks = partition(response, 5)
	)

	$scope.displayInstanceInfo = (instance) ->
		$scope.sideBarMessage = "Instance Hey"
]