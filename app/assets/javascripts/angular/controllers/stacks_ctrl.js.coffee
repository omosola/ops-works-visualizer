App.controller 'StacksCtrl', ['$scope', 'Stacks', ($scope, Stacks) ->

	partition = (array, numPartitions) ->
		result = []
		size = numPartitions
		while (array.length > 0)
			result.push(array.splice(0,size))
		result

	############################################################################################
	## TODO List:
	## 1) Move detailsBox to a directive
	##		* What I would like - Mouseove on a layer, elb, stack title, or instance
	##		 and have the info displayed
	##		* Hide detailsBox when you mouseout of any of the above elements
	## 2) Use a template for the detailsBox instead of generating the HTML in the controller
	## 		* Gives me more control over the look of the detailsBox
	##
	############################################################################################

	$scope.numPartitions = 4

	Stacks.query((response) ->
		# partition indicates the number of stacks to display per row
		$scope.splitStacks = partition(response, $scope.numPartitions)
	)

	$scope.events = {}
	$scope.events.updateDetailsBox = (event, obj) ->

			detailsBoxMessage = "<div> </p>Details: </p>"
			for key,value of obj
				if(typeof(value) == "string")
					detailsBoxMessage += "<p>" + key + " : " + obj[key] + "</p>"
			detailsBoxMessage += "</div>"

			$scope.detailsBoxMessage = detailsBoxMessage

			# TODO: Use Directives for DOM manipulation instead of calling
			# JQUERY directly from Controller!

			$('#details-box').css({
				'top': event.pageY,
				'left': event.pageX
			})

]