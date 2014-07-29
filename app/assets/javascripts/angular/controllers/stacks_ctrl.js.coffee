App.controller 'StacksCtrl', ['$scope', 'Stacks', ($scope, Stacks) ->

	$scope.stacks = Stacks.query()

	# TASKS:
	# Toggling off all instances which match the name of the checked instance (2-4PM)
	# Clean up getAllInstances method (2-4PM)
	# Style select dropdown (4-5PM)
	# Style side bar (4-5PM)
	# PDF/PNG of page (5-6PM)
	# Centering instances! (Until Lunch)
	# Styling of display page (4-5PM)

	## TODO: Current issue, I need a way, using angular, to
	# display all of the instances that match the checked instance
	# even if they have a different hash key.
	# what would be best would be to delete the hashkey, if possible
	$scope.getAllInstances = (stackObj) ->
		if !stackObj
			return

		uniqueInstances = {}

		# add each of the instances in the stack
		# instances are considered unique
		# if they have different host names
		for layer in stackObj.layers
			for instance in layer.instances
				uniqueInstances[instance['$$hashKey']] = instance

		# convert from the uniqueInstances map
		# to array
		uniqueInstancesArr = []
		for key, instanceObj of uniqueInstances
			uniqueInstancesArr.push(instanceObj)

		uniqueInstancesArr
]