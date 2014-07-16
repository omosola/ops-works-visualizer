App.controller 'StacksCtrl', ['$scope', 'Stacks', ($scope, Stacks) ->

	partition = (array, numPartitions) ->
		result = []
		size = numPartitions
		while (array.length > 0)
			result.push(array.splice(0,size))
		result

	# TODO
	# Would prefer to not have the 5 hardcoded
	# and also would be better to divorce the view
	# from the controller, which isn't currently the
	# case (5 & col-md-2)
	Stacks.query((response) ->
		$scope.split_stacks = partition(response, 4)
	)

	$scope.events = {}
	$scope.events.updateDetailsBoxMessage = (event, obj) ->

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

# TODO: Hide when mouse leaves stack canvas area